class CurrentCode
  @@code     = ""
  @@result   = ""
  @@observer = false

  def self.code
    @@code
  end

  def self.set_code(new_code)
    @@code = new_code unless @@code == new_code
  end

  def self.result
    @@result
  end

  def self.set_result(new_result)
    @@result = new_result unless @@result == new_result
  end
end
