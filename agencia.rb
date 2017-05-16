require './classes/processa_balanco'


	arquivo_contas = open(ARGV[0])
	arquivo_transacoes = open(ARGV[1])
	ProcessaBalanco.new(arquivo_contas, arquivo_transacoes)