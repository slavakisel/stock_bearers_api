class ApplicationController < ActionController::API
  include ErrorsRescuer
  include Pagination
end
