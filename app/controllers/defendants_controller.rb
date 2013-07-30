class DefendantsController < ApplicationController
  def update
    claim = Claim.find(params[:claim_id])
    defendant = Defendant.find(params[:id])

    hide_editor

    if params[:commit].downcase == 'save'
      params.permit!
      defendant.update_attributes!(params[:defendant])
    end

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { redirect_to claim_defendant_path claim, defendant }
    end
  end

  def new
    claim = Claim.find(params[:claim_id])
    defendant = Defendant.new(Person.generate)
    claim.defendants << defendant

    session[claim.id][defendant.id] = true

    redirect_to claim_path claim
  end

  def show
    @claim = Claim.find(params[:claim_id])
    @defendant = Defendant.find(params[:id])

    respond_to do |format|
      format.html { redirect_to claim_path @claim }
      format.js { render partial: 'defendants/save', locals: {defendant: @defendant} }
    end
  end

  def create
    @claim = Claim.find(params[:claim_id])

    hide_editor

    if params[:commit].downcase == 'save'
      params.permit!
      defendant = Defendant.create(params[:defendant])
      @claim.defendants << defendant
      @claim.save
    end
    
    respond_to do |format|
      format.html { redirect_to claim_path @claim }
      format.js { render partial: 'defendants/save', locals: {defendant: defendant}  }
    end
  end

  def hide_editor
    claim = Claim.find(params[:claim_id])
    session[claim.id] ||= {}
    session[claim.id][params[:id].to_i] = false
  end

  def show_editor
    claim = Claim.find(params[:claim_id])
    session[claim.id] ||= {}
    session[claim.id][params[:id].to_i] = true
    redirect_to claim_path claim
  end
end