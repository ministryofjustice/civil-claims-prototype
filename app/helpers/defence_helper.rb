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
      { :text => 'Confirmation', :path => 'confirm' }
    ]
  end

end