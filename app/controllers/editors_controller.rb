class EditorsController < ApplicationController
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
    eval(File.read(path))
    result = %x[cd #{Rails.root} && rspec spec/lib/#{num}_spec.rb --format html]
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
end
