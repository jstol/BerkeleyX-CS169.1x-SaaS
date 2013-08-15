class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
	raise WrongNumberOfPlayersError unless game.length == 2
	player1 = game[0];
	player2 = game[1];
	if player1[1] == "R"
		return player1 if (player2[1] == "S" || player2[1] == "R")
	elsif player1[1] == "P"
		return player1 if (player2[1] == "R" || player2[1] == "P")
	elsif player1[1] == "S"
		return player1 if (player2[1] == "P" || player2[1] == "S")
	else
		raise NoSuchStrategyError
	end
	
	raise NoSuchStrategyError if !(player2[1] =~ /^R$|^P$|^S$/)
	return player2
end

def rps_tournament_winner(tournament)
  if tournament[0][0].is_a? Array
		winner1 = rps_tournament_winner(tournament[0])
		winner2 = rps_tournament_winner(tournament[1])
		return rps_game_winner([winner1,winner2])
	else
		return rps_game_winner(tournament)
	end
end