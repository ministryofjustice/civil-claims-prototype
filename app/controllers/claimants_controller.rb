class ClaimantsController < ApplicationController
  def update
    claim = Claim.find(params[:claim_id])
    claimant = Claimant.find(params[:id])

    hide_editor

    if params[:commit].downcase == 'save'
      params.permit!
      claimant.update_attributes!(params[:claimant])
    end

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { redirect_to claim_claimant_path claim, claimant }
    end
  end

  def new
    claim = Claim.find(params[:claim_id])
    claimant = Claimant.new(Person.generate)
    claim.claimants << claimant

    session[claim.id][claimant.id] = true

    redirect_to claim_path claim
  end

  def show
    @claim = Claim.find(params[:claim_id])
    @claimant = Claimant.find(params[:id])

    respond_to do |format|
      format.html { redirect_to claim_path @claim }
      format.js { render partial: 'claimants/save', locals: {claimant: @claimant} }
    end
  end

  def create
    @claim = Claim.find(params[:claim_id])

    hide_editor

    if params[:commit].downcase == 'save'
      params.permit!
      claimant = Claimant.create(params[:claimant])
      @claim.claimants << claimant
      @claim.save
    end
    
    respond_to do |format|
      format.html { redirect_to claim_path @claim }
      format.js { render partial: 'claimants/save', locals: {claimant: claimant}  }
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