require_relative './conta'
require_relative './transacao'

class ProcessaBalanco
	attr_accessor :arquivo_contas, :arquivo_transacoes, :contas
	def initialize(arquivo_contas, arquivo_transacoes)
		@arquivo_contas = arquivo_contas
		@arquivo_transacoes = arquivo_transacoes
		cria_hash_contas_transacoes(processa_arquivo_contas, processa_transacoes)
		efetua_balanco
	end

	def processa_arquivo_contas
		begin
			contas_com_saldo = ajusta_contas(formata(IO.readlines(@arquivo_contas)))
		rescue Exception => msg  
			puts "#{msg}"
		end
		contas_com_saldo
	end

	def processa_transacoes
		begin
			transacoes_com_valor = (formata(IO.readlines(@arquivo_transacoes)))
			transacoes_array = ajusta_transacoes(transacoes_com_valor)
		rescue Exception => msg  
			puts "#{msg}"
		end
		transacoes_array
	end

	def cria_hash_contas_transacoes(hash_contas, array_transacoes)
		array_transacoes.each do |t|
			hash_contas[t[0]] << t[1]
		end
		@contas = cria_contas(hash_contas)
	end

	def efetua_balanco
		balanco = ""
		@contas.each do |conta|
			conta.transaciona
			balanco << c.numero.to_s << "," << c.saldo.to_s << "\n"
		end
		puts balanco
	end

	def formata(contas_ou_transacoes)
		contas_ou_transacoes_formatado = []
		raise "Arquivo não pode estar vazio" if contas_ou_transacoes.empty?
		contas_ou_transacoes.each do |contas_ou_transacoes|
			contas_ou_transacoes.delete!("\n")
			contas_ou_transacoes_formatado  << contas_ou_transacoes.split(",")
		end
		contas_ou_transacoes_formatado 
	end

	def ajusta_contas (contas_com_saldo)
		contas_com_saldo.flatten!.map! { |x| Integer(x) }
		contas_hash = Hash[*contas_com_saldo]
		contas_hash.each do |k,v|
			values = []
			contas_hash[k] = values << v
		end
		contas_hash
	end

	def ajusta_transacoes(transacoes_com_valor)
		transacoes_com_valor.each do |t|
			t.map! { |x| Integer(x) }
		end
		transacoes_com_valor
	end

	def cria_contas(contas_com_saldo)
		@contas = []
		contas_com_saldo.each do |k,v|
			c = Conta.new(k,v)
			@contas << c
		end
		@contas
	end
end