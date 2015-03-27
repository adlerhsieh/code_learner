class EditorsController < ApplicationController
  def index
    
  end

  def evaluate
    code_array = params[:code]
    if code_array.class == Array && code_array.length > 0
      @code_string = code_array.inject("") { |result, line| result += line + ";"}
    end
    result = eval(@code_string)
    render :json => {:result => result}
  end
end
