class CurrentCode
  @@code     = ""
  @@result   = ""
  @@observer = false
  @@q        = 0

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

  def self.observer
    @@observer
  end

  def self.set_observer(bool)
    @@observer = bool unless @@observer == bool
  end

  def self.q
    @@q
  end

  def self.set_q(int)
    @@q = int unless @@q == int
  end
end
