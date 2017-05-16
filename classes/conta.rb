class Conta
	attr_accessor :numero, :saldo
	def initialize(numero, saldo)
		@numero = numero
		@trasacoes_da_conta = saldo
	end

	def transaciona
		@saldo = @trasacoes_da_conta.first
		if @trasacoes_da_conta.size != 1
			@trasacoes_da_conta.shift
			@trasacoes_da_conta.each do |transacao|
				@saldo = @saldo + transacao
				aplica_multa(transacao)
			end
		end
	end

	def aplica_multa(transacao)
		if (transacao < 0 && @saldo <0)
			@saldo = @saldo - 500
		end
	end
end