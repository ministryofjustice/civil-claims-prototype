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
    current_page = -1
    defence_navigation_linkdata.each_with_index do |lnk, i|
      if lnk[:path] == session[:referer]
        current_page = i
      elsif current_page > -1
        return url_for( controller: 'defences', action: lnk[:path], only_path: true )
      end
    end
    return root_path
  end


end