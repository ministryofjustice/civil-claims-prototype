module DefenceHelper
  def render_defence_navigation
    render :partial => 'shared/navigation', :locals => { :links => defence_navigation_linkdata }
  end

  def defence_navigation_linkdata
    link_data = [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'About the claim', :path => 'about_claim' },
      { :text => 'About you', :path => 'about_defence' },
      { :text => 'Preview and submit', :path => 'preview' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end

  def get_defence_next_navigation_path( referer )
    link_data = defence_navigation_linkdata

    current_page_index = link_data.index{|lnk| lnk[:path] == session[:referer]}
    if current_page_index
      return url_for( controller: 'defences', action: link_data[(current_page_index + 1).modulo(link_data.length)][:path], only_path: true )
    else
      return root_path
    end

  end


end