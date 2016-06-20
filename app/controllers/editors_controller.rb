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
    num = 1
    File.open("#{Rails.root}/lib/code/1.rb", "w+") {|file| file.write(@code_string) }
    result = %x[cd #{Rails.root} && rspec spec/lib/#{num}_spec.rb --format html]
    render :json => {:result => result}
  end

  def parse_code
    code_array = params[:code]
    if code_array.class == Array && code_array.length > 0
      @code_string = code_array.inject("") { |result, line| result += line + ";"}
    end
  end
end
