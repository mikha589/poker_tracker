class PokerSessionsController < ApplicationController

    before_action :set_poker_session, only: [:edit, :update, :destroy]

    def index
        @poker_sessions = current_user.poker_sessions.all
    end

    def show 
    end

    def new
        @poker_session = current_user.poker_sessions.build
    end

    def create
        @poker_session = current_user.poker_sessions.build(poker_session_params)
        if @poker_session.save 
            redirect_to poker_sessions_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @poker_session.update(poker_session_params)
            redirect_to poker_sessions_path
        else
            render :edit
        end
    end

    def destroy 
        @poker_session.destroy
        redirect_to poker_sessions_path
    end

    private

    def set_poker_session
        @poker_session = current_user.poker_sessions.find(params[:id])
    end

    def poker_session_params
        params.require(:poker_session).permit(:date, :location, :game_format, :limit, :duration, :buy_in , :cashout, :notes)
    end
end
