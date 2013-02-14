Spree::StatesController.class_eval do

  def by_country
    states = Spree::State.where(:country_id => params[:country_id]).order('name ASC')
    res = ["<option value=\"\">#{I18n.translate(:please_select)}</option>"]
    unless states.empty?
      states.each do |s|
        res << "<option value=\"#{s.id}\">#{s.name}</option>"
      end
    end

    render :json => {:states => res.join}

  end
end