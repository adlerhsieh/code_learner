Code.delete_all
User.delete_all

require 'digest'
require 'securerandom'
pass = SecureRandom.hex(3)
User.create([
  {
    account: 'boom',
    password: Digest::SHA256.hexdigest('beach'),
    admin: true
  },
  {
    account: SecureRandom.hex(3),
    password: Digest::SHA256.hexdigest(pass),
    original_password: pass,
    admin: false
  }
])

Code.create(
  q: 0,
  description: "建立一個method名稱為plus，可以將兩個帶入的參數相加，\n"\
  "例如：plus(1,2)將得到結果3",
  content: "def plus(x, y)\n"\
  "\n"\
  "end"
)
