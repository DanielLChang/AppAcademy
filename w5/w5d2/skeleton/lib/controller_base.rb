require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
    @already_built_response = false
  end

  # Helper method to alias @already_built_response

  def protect_from_forgery
    @authenticity_token = generate_authenticity_token
  end

  def authenticity_token
    @authenticity_token
  end

  def generate_authenticity_token
    SecureRandom.urlsafe_base64(128)
  end

  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)

    raise "double render error" if already_built_response?

    @res.status = 302
    @res['Location'] = url

    @already_built_response = true

    session.store_session(@res)
    # flash.store_flash(@res)

  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)

    raise "double render error" if already_built_response?

    @res.write(content)
    @res['Content-Type'] = content_type

    @already_built_response = true

    session.store_session(@res)
    # flash.store_flash(@res)

  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)

    controller_name = self.class.name.underscore
    path = "views/#{controller_name}/#{template_name}.html.erb"
    content = File.read(path)

    content = ERB.new(content).result(binding)
    content_type = "text/html"

    render_content(content, content_type)

  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)

    send(name)
    render(name) unless already_built_response?

  end

end
