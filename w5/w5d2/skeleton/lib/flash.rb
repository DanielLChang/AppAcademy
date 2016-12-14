require 'json'

class Flash
  
  attr_reader :flash_now

  def initialize(req)
    flash_cookie = req.cookies["_rails_lite_app_flash"]

    @flash_now = flash_cookie ? JSON.parse(flash_cookie) : {}
    @flash_cookie = {}
  end

  def [](key)
    @flash_now[key.to_s] || @flash_cookie[key.to_s]
  end

  def []=(key, val)
    @flash_cookie[key] = val
  end

  def now
    @flash_now
  end

  def store_flash(res)
    attributes = { value: @flash_cookie.to_json, path: '/' }
    res.set_cookie('_rails_lite_app_flash', attributes)
  end

end
