class GithubDatatable

  include Rails.application.routes.url_helpers


  delegate :params, :h, :link_to, :number_to_currency, :url_helpers, to: :@view

  def initialize(view, token)
    @view = view
    @github = Github.new(:oauth_token => token)

  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: params[:sSearch].present? ? @github.search.repos(q: params[:sSearch]).total_count : 1,
      iTotalDisplayRecords: params[:sSearch].present? ? @github.search.repos(q: params[:sSearch]).total_count : 1,
      aaData: data
    }
  end

private

  def data
    if results
      results.items.map do |result|
        [
          result.name,
          result.language,
          result.stargazers_count
        ]
      end
    else
      [['na', 'na', 'na']]
    end
  end

  def results
    @results ||= fetch_results
  end

  def fetch_results

    if params[:sSearch].present?
      results = @github.search.repos(q: params[:sSearch], sort: sort_column, order: sort_direction, page: page)
    end
    if params[:sSearch_1].present?
      results = @github.search.repos(q: params[:sSearch] + "+language:#{params[:sSearch_1]}", page: page)
    end    
 

  
    results
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i
  end

  def sort_column
    columns = %w[repo language stars]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end