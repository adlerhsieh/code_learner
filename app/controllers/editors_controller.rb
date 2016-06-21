class EditorsController < ApplicationController
  before_action :authenticate

  def index
    @q    = params[:q] || 0
    @code = Code.find_by_q(@q)
  end

  def evaluate
    parse_code
    result = eval(@code_string)
    render :json => {:result => result}
  end

  def spec
    parse_code
    num = params[:q] || 0
    path = "#{Rails.root}/lib/code/#{num}.rb"
    File.open(path, "w+") {|file| file.write(@code_string) }
    if code_valid?
      eval(File.read(path))
      result = %x[cd #{Rails.root} && rspec spec/lib/#{num}_spec.rb --format html]
    else
      result = '錯誤'
    end
    render json: {
      result: result,
      status: 'ok'
    }
  end

  def realtime
    render json: {
      code:   CurrentCode.code.join("\n"),
      result: CurrentCode.result
    }
  end

  def set_realtime
    CurrentCode.set_code(params[:code])     if params[:code]
    CurrentCode.set_result(params[:result]) if params[:result]
    render json: {
      result: 'ok'
    }
  end

  private

  def parse_code
    code_array = params[:code]
    if code_array.class == Array && code_array.length > 0
      @code_string = code_array.inject("") { |result, line| result += line + ";"}
    end
  end

  def authenticate
    redirect_to '/' unless current_user
  end

  def code_valid?
    ['File', 'FileUtils', 'rm -rf', 'system(', 'system ', '%x['].any? {|str| @code_string.include?(str) }.!
  end
end
