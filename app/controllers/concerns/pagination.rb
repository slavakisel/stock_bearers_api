module Pagination
  def pagination_meta(page)
    {
      current_page: page.current_page,
      total_pages: page.total_pages
    }
  end
end
