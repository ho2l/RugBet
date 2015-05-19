class GamesController < ApplicationController
  before_filter :authenticate_user!, only:[:new,:show,:edit,:create,:update,:destroy]
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @isPlayed = "Not played"
    if @game.s2 != nil
      @isPlayed = @game.s1.to_s+" - "+@game.s2.to_s 
    end
    if Bet.find_by(game_id: @game.id, user_id: current_user.id)
      @betted = true
      @betDone = Bet.find_by(game_id: @game.id, user_id: current_user.id)
    else
      @betted = false
    end
    @bet = Bet.new
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end


  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:id, :description, :pool, :e1, :e2, :s1, :s2, :start, :end, :location)
    end
end
