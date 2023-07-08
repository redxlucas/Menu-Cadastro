programa
{
	// Disciplina: Algoritmos - TADS 2023/1
	// Autores: Lucas Azevedo da Silva, Natan Feijó Tristão

//----------------------------------------------------------------

	inclua biblioteca Tipos --> t
	inclua biblioteca Util --> u
	inclua biblioteca Texto --> txt
	inclua biblioteca Calendario --> c

//-----------------------------------------------------------------------------------------------------

	funcao zeraVetor(cadeia a[], inteiro b[], inteiro c[], inteiro d[], inteiro f[], inteiro z[], cadeia g[], cadeia j[], cadeia h[], cadeia k[], inteiro min, inteiro lim)
	{
		inteiro i
		para(i = min; i < lim; i++)
			{
				a[i] = "-1"//Nome
				b[i] = -1//Código
				c[i] = -1//Dia
				d[i] = -1//Mês
				f[i] = -1//Ano
				z[i] = -1//Idade
				g[i] = "-1"//Sexo
				h[i] = "-1"//Profissão
				j[i] = "-1"//Cidade
				k[i] = "-1"//Tipo sanguíneo
			}
	}
	
//-----------------------------------------------------------------------------------------------------

	funcao verificaCadeia(cadeia a, logico &b)//Procedimento que verifica se a cadeia 'a' possui números inteiros ou reais.
	{
		se(t.cadeia_e_inteiro(a, 10) ou t.cadeia_e_real(a))
		{
			limpa()
			escreva("Valor inválido! Insira novamente.\n")
			u.aguarde(700)
		}
		senao
		{
			b = falso
		}
	}

//-----------------------------------------------------------------------------------------------------

	funcao inteiro idade(inteiro dia, inteiro mes, inteiro ano)//Função que faz a conversão de idade com base na data de nascimento e no calendário da máquina.
	{
		inteiro a
		se(mes > c.mes_atual())
		{
			a = c.ano_atual() - ano - 1
		}
		senao se(mes == c.mes_atual())
		{
			se(dia > c.dia_mes_atual())
			{
				a = c.ano_atual() - ano - 1
			}
			senao
			{
				a = c.ano_atual() - ano
			}
		}
		senao
		{
			a = c.ano_atual() - ano
		}
		retorne a
	}

//-----------------------------------------------------------------------------------------------------

	funcao cadastroVazio(inteiro a, logico &b)//Procedimento para verificar se nâo há algum cadastro no sistema (A = contador de cadastros; B = variavel logica para apenas liberar caso aja um cadastro)
	{
		se(a == 0)
		{
			limpa()
			escreva("Não há nenhum cadastro no sistema.\n\n")
			u.aguarde(700)
			b = falso
		}
	}

//-----------------------------------------------------------------------------------------------------	

	funcao sair(cadeia a, logico &b)
	{
		escreva("\nPressione qualquer tecla para sair: ")
		leia(a)
		b = falso
		limpa()
	}

//-----------------------------------------------------------------------------------------------------

	funcao cadeia genero(inteiro a, cadeia b)//Função que lê um número de entrada e retorna com o sexo
	{
		escolha(a)
		{
			caso 1:
				b = "Masculino"
			pare

			caso 2:
				b = "Feminino"
			pare	
		}
		retorne b
	}

//-----------------------------------------------------------------------------------------------------

	funcao verificaLim(inteiro a, inteiro b, inteiro c, logico &d)//Procedimento que faz uma verificação com limite pré-definido
	{
		se(a < b ou a > c)
		{
			limpa()
			escreva("Valor inválido! Insira novamente.\n\n")
			u.aguarde(700)
		}
		senao
		{
			d = falso
		}
	}

//-----------------------------------------------------------------------------------------------------

	funcao logico verifica(inteiro a, inteiro b[], inteiro c, inteiro &d, inteiro f)//Função que verifica a entrada 'a' dentro do vetor 'b' e retorna um valor lógico, além de informar a posição como referência.
	{
		inteiro i = 0, cont = 0, pos = 0
		logico res = falso

		para(i = 0; i < c; i++)
		{
			se(a == b[i])
			{
				cont++
				pos = i
			}
		}
		
		se(cont >= f)
		{
			res = verdadeiro
			d = pos
		}	
		retorne res
	}
	
//-----------------------------------------------------------------------------------------------------

	funcao nascCadastro(inteiro dia[], inteiro mes[], inteiro ano[], inteiro id[], inteiro pos, cadeia a)//Função para cadastrar data de nascimento
	{
		logico cadastro = verdadeiro
		escreva(a)
		escreva("\nData de nascimento\n\n")
		
		enquanto(cadastro)
		{
			escreva("- Insira o dia: ")
			leia(dia[pos])
			verificaLim(dia[pos], 1, 31, cadastro)
		}
		cadastro = verdadeiro
		enquanto(cadastro)
		{
			escreva("- Insira o mês: ")
			leia(mes[pos])
			verificaLim(mes[pos], 1, 12, cadastro)
		}
		cadastro = verdadeiro
		enquanto(cadastro)
		{
			escreva("- Insira o ano: ")
			leia(ano[pos])
			verificaLim(ano[pos], 1900, c.ano_atual(), cadastro)
		}
									
		id[pos] = idade(dia[pos], mes[pos], ano[pos])
		limpa()
	}

//-----------------------------------------------------------------------------------------------------

	funcao verificaCod(inteiro a, inteiro b[], inteiro c, inteiro d, inteiro f, logico &g)
	{
		se(verifica(a, b, c, d, f))
		{
			limpa()
			escreva("Código já cadastrado! Insira novamente.\n")
			u.aguarde(700)
		}
		senao
		{
			g = falso
		}
	}

//-----------------------------------------------------------------------------------------------------

	funcao lista(cadeia a[], inteiro b[], inteiro c[], inteiro d[], inteiro f[], inteiro g[], cadeia l[], cadeia j[], cadeia h[], cadeia k[], inteiro i)
	{
		escreva("\nNome: ",a[i],"\n")
		escreva("Código: ",b[i],"\n")
		escreva("Data de nascimento: ",c[i],"/",d[i],"/",f[i]," (",g[i]," anos)","\n")
		escreva("Sexo: ",l[i],"\n") 
		escreva("Profissão: ",j[i],"\n")
		escreva("Cidade: ", h[i], "\n")
		escreva("Tipo Sanguíneo: ", k[i],"\n")
		escreva("\n•-------------------------------------------•\n")
	}

//-----------------------------------------------------------------------------------------------------

	funcao inicio()
	{
		const inteiro col = 30//Número de colunas de todos os vetores
		cadeia nome[col], sexo[col], prof[col], cidade[col], sang[col]//Vetores de cadeia
		inteiro cod[col], nascDia[col], nascMes[col], nascAno[col], id[col]//Vetores de inteiros
		logico menu = verdadeiro, contConsulta, menuVerificar
		inteiro i = 0, j = 0, contCadastro = 0, pos = 0, contRegistro = 0
		
		inteiro entrada = 0//Variável genérica do tipo inteiro
		cadeia entradaCadeia = ""//Variável genérica do tipo cadeia

		zeraVetor(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, 0, col)

		enquanto(menu)	
		{
			escreva("\t-- Sistema --\n")
			escreva("\n\t1 - Cadastrar")
			escreva("\n\t2 - Consultar")
			escreva("\n\t3 - Listar")
			escreva("\n\t4 - Alterar")
			escreva("\n\t5 - Excluir")
			escreva("\n\t6 - Relatório")
			escreva("\n\t7 - Sair\n")
			
			escreva("\nInsira o número desejado: ")	
			leia(entrada)
		
			escolha(entrada)
			{
				
//-----------------------------------------------------------------------------------------------------

				caso 1:
					limpa()
					menuVerificar = verdadeiro

					se(contCadastro == col e nao verifica(-1, cod, contCadastro, pos, 1))
					{
						escreva("Limite de cadastros atingido! Exclua para cadastrar mais pessoas.\n\n")
						u.aguarde(700)
					}
					senao
					{
						se(verifica(-1, cod, contCadastro, pos, 1))
						{
							verifica(-1, cod, contCadastro, pos, 1)
						}
						senao
						{
							pos = contCadastro
							contCadastro++
						}

//---------------------------------------------------------
						
						escreva("\t-- Cadastrar --\n")//NOME
						enquanto(menuVerificar)
						{
							escreva("\nInsira o nome: ")
							leia(nome[pos])
							verificaCadeia(nome[pos], menuVerificar)
						}
						limpa()

//---------------------------------------------------------
						
						escreva("\t-- Cadastrar --\n")//CÓDIGO
						menuVerificar = verdadeiro
						enquanto(menuVerificar)
						{	
							escreva("\nInsira o código: ")
							leia(cod[pos])
							verificaCod(cod[pos], cod, col, pos, 2, menuVerificar)
						}
						limpa()

//---------------------------------------------------------
						
						menuVerificar = verdadeiro
						nascCadastro(nascDia, nascMes, nascAno, id, pos, "\t-- Cadastrar --\n")

//---------------------------------------------------------

						escreva("\t-- Cadastrar --\n\n")//SEXO
						menuVerificar = verdadeiro
						enquanto(menuVerificar)
						{
							escreva("1 - Masculino \n2 - Feminino \n\nInsira o sexo: ")
							leia(entrada)
							verificaLim(entrada, 1, 2, menuVerificar)
							sexo[pos] = genero(entrada, sexo[pos])
						}
						limpa()

//---------------------------------------------------------
						
						escreva("\t-- Cadastrar --\n")//PROFISSÃO
						menuVerificar = verdadeiro
						enquanto(menuVerificar)
						{
							escreva("\nInsira a profissão da pessoa: ")
							leia(prof[pos])

							verificaCadeia(prof[pos], menuVerificar)
						}
						limpa()

//---------------------------------------------------------
						
						escreva("\t-- Cadastrar --\n")//CIDADE
						menuVerificar = verdadeiro
						enquanto(menuVerificar)
						{
							escreva("\nInsira a cidade em que a pessoa reside: ")
							leia(cidade[pos])
							
							verificaCadeia(cidade[pos], menuVerificar)
						}
						limpa()

//---------------------------------------------------------
					
						escreva("\t-- Cadastrar --\n")//TIPO SANGUÍNEO
						menuVerificar = verdadeiro
						enquanto(menuVerificar)
						{
							escreva("\nInsira o tipo sanguíneo da pessoa: ")
							leia(sang[pos])

							verificaCadeia(sang[pos], menuVerificar)
						}
						limpa()

//---------------------------------------------------------

						escreva("Paciente cadastrado!\n\n")
						u.aguarde(700)
					}
				pare
				
//-----------------------------------------------------------------------------------------------------

				caso 2:
					contConsulta = verdadeiro//Zera o contador da consulta
					
					cadastroVazio(contCadastro, contConsulta)
					se(contConsulta)
					{
						limpa()
						escreva("\t-- Consultar --\n\n")
						escreva("Insira o código do cadastro a ser verificado: ")
						leia(entrada)//Recebe o código de entrada a ser verificado 
						limpa()
						para(i = 0; i < col; i++)//Inicia o verificador se o valor inserido na entrada está presente no vetor de códigos
						{
					
							se(entrada == cod[i])//Se possui o código estar presente, apresenta o cadastro do cliente 
							{
								escreva("\t-- Consultar --\n")
								lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
								sair(entradaCadeia, contConsulta)
							}
						}
						se(contConsulta)//Caso o código não exista no sistema
						{
							limpa()
							escreva("O código ",entrada," não foi encontrado no sistema.\n\n")
							u.aguarde(700)
						}
					}
				pare
								
//------------------------------------------------------------------------------------------------------

				caso 3:
					contConsulta = verdadeiro
					cadastroVazio(contCadastro, contConsulta)
					se(contConsulta)
					{
						limpa()
						escreva("\t-- Listar --\n")
						para(i = 0; i < col; i++)
						{
							se(cod[i] != -1)
							{
								lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
							}
						}
						sair(entradaCadeia, contConsulta)
					}
				pare 
	
//------------------------------------------------------------------------------------------------------		

				caso 4:
					contConsulta = verdadeiro
					cadastroVazio(contCadastro, contConsulta)
					se(contConsulta)
					{
						limpa()
						escreva("\t-- Alterar --\n\n")
						escreva("Insira o código do cadastro a ser verificado: ")
						leia(entrada)
						se(verifica(entrada, cod, col, pos, 1))
						{
							limpa()
							escreva("\t-- Alterar --\n")
							escreva("\t\n1 - Nome")
							escreva("\t\n2 - Código")
							escreva("\t\n3 - Data de Nascimento")
							escreva("\t\n4 - Sexo")
							escreva("\t\n5 - Profissão")
							escreva("\t\n6 - Cidade")
							escreva("\t\n7 - Tipo Sanguíneo")
							escreva("\t\n\nQual dos campos você deseja alterar? ")
							leia(entrada)

							escolha(entrada)
							{
								caso 1:
									limpa()
									menuVerificar = verdadeiro
									enquanto(menuVerificar)
									{
										limpa()
										escreva("\t-- Alterar --\n\n")
										escreva("O nome '",nome[pos],"' será alterado para: ")
										leia(nome[pos])
										verificaCadeia(nome[pos], menuVerificar)
									}
									limpa()
									escreva("Nome alterado!\n\n")
									u.aguarde(700)
								pare

//---------------------------------------------------------

								caso 2:
									menuVerificar = verdadeiro
									enquanto(menuVerificar)
									{
										limpa()
										escreva("\t-- Alterar --\n\n")
										escreva("O código '",cod[pos],"' será alterado para: ")
										leia(cod[pos])
										verificaCod(cod[pos], cod, col, pos, 2, menuVerificar)
									}
									limpa()
									escreva("Código alterado!\n\n")
									u.aguarde(700)
								pare

//---------------------------------------------------------

								caso 3:
									menuVerificar = verdadeiro
									limpa()
									nascCadastro(nascDia, nascMes, nascAno, id, pos,"\t-- Alterar --\n")
									escreva("Data de nascimento alterada!\n\n")
									u.aguarde(700)
								pare

//---------------------------------------------------------

								caso 4:
									menuVerificar = verdadeiro
									enquanto(menuVerificar)
									{
										limpa()
										escreva("\t-- Alterar --\n\n")
										escreva("\n1 - Masculino \n2 - Feminino \n\n)O sexo será alterado para: ")
										leia(entrada)
										verificaLim(entrada, 1, 2, menuVerificar)
										sexo[pos] = genero(entrada, sexo[pos])
									}
									limpa()
									escreva("Sexo alterado!\n\n")
									u.aguarde(700)
								pare

//---------------------------------------------------------

								caso 5:
									limpa()
									escreva("\t-- Alterar --\n\n")
									escreva("A profissão ",prof[pos]," será alterado para: ")
									leia(prof[pos])
									verificaCadeia(prof[pos], menuVerificar)
									limpa()
									escreva("Profissão alterada!\n\n")
									u.aguarde(700)			
								pare
								
//---------------------------------------------------------

								caso 6:
									limpa()
									escreva("\t-- Alterar --\n\n")
									escreva("A cidade ", cidade[pos]," será alterado para: ")
									leia(cidade[pos])
									verificaCadeia(cidade[pos], menuVerificar)
									limpa()
									escreva("Cidade alterado!\n\n")
									u.aguarde(700)
									
								pare
								
//---------------------------------------------------------

								caso 7:
									limpa()
									escreva("\t-- Alterar --\n\n")
									escreva("O tipo sanguíneo será alterado para: ")
									leia(sang[pos])
									limpa()
									escreva("Tipo sanguíneo alterado!\n\n")
									u.aguarde(700)
								pare
								
//---------------------------------------------------------

								caso contrario:
									limpa()
									escreva("Valor inválido!\n\n")
									u.aguarde(700)
							}
						}
						senao
						{
							limpa()
							escreva("O código ",entrada," não foi encontrado no sistema.\n\n")
							u.aguarde(700)
						}
					}
				pare
//------------------------------------------------------------------------------------------------------

				caso 5:
					contConsulta = verdadeiro 
					cadastroVazio(contCadastro, contConsulta)
					se(contConsulta)
					{
						limpa()
						escreva("\t-- Excluir --\n")//Excluir anula todo o código, tornando cadeia em "*" e inteiro em -1
						escreva("\t\nInsira o código do cadastro que deseja excluir: ")
						leia(entrada)
						limpa()
						se(verifica(entrada, cod, col, pos, 1))
						{
							zeraVetor(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, pos, pos+1)
							limpa()

							se(verifica(-1, cod, col, pos, col))
							{
								contCadastro = 0
							}
							escreva("O cadastro ",entrada," foi excluído do sistema.\n\n")
							u.aguarde(700)
						}
						senao
						{
							escreva("O código ",entrada," não foi encontrado no sistema.\n\n")
							u.aguarde(700)
						}
						
					}
				pare
//------------------------------------------------------------------------------------------------------

				caso 6:
					contConsulta = verdadeiro
					cadastroVazio(contCadastro, contConsulta)
					se(contConsulta)
					{
						limpa()
						escreva("\t-- Relatório --\n\n")
						escreva("1 - Pessoas do sexo masculino\n")
						escreva("2 - Pessoas com o sangue tipo O-\n")
						escreva("3 - Pessoas maiores de 18 anos que moram em Canoas\n")
						escreva("4 - Pessoas que trabalham como professor(a)\n")
						escreva("5 - Pessoas do sexo feminino que moram em Gravataí\n\n")
						escreva("Quais dos relatórios deseja verificar? ")
						leia(entrada)
						limpa()
						
						escolha(entrada)
						{
//---------------------------------------------------------
							
							caso 1:
								contRegistro = 0
								escreva("\t-- Relatório de pessoas do sexo masculino --\n")
								para(i = 0; i < col; i++)
								{
									se(sexo[i] == "Masculino" e cod[i] != -1)
									{
											lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
											contRegistro++
									}
								}
								escreva("\nHá ",contRegistro," pessoa(s) do sexo masculino.\n")
								sair(entradaCadeia, contConsulta)
							pare

//---------------------------------------------------------
							
							caso 2:
								contRegistro = 0
								escreva("\t-- Relatório de pessoas com o sangue tipo O- --\n")
								para(i = 0; i < col; i++)
								{
									se(sang[i] == "O-" e cod[i] != -1)
									{
											lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
											contRegistro++
									}
								}
								escreva("\nHá ",contRegistro," pessoa(s) com o tipo sanguíneo O-.\n")
								sair(entradaCadeia, contConsulta)
							pare
							
//---------------------------------------------------------	

							caso 3:
								contRegistro = 0
								escreva("\t-- Relatório de pessoas maiores de idade que moram em Canoas --\n")
								para(i = 0; i < col; i++)
								{
									se(cidade[i] == "Canoas" e id[i] >= 18 e cod[i] != -1)
									{
											lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
											contRegistro++
									}
								}
								escreva("\nHá ",contRegistro," pessoa(s) maiores de idade que moram em Canoas.\n")
								sair(entradaCadeia, contConsulta)
							pare

//---------------------------------------------------------

							caso 4:
								contRegistro = 0
								escreva("\t-- Relatório de pessoas que trabalham como professor(a) --\n")
								para(i = 0; i < col; i++)
								{
									se(prof[i] == "Professor" ou prof[i] == "Professora" e cod[i] != -1)
									{
											lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
											contRegistro++
									}
								}
								escreva("\nHá ",contRegistro," pessoa(s) que trabalham como professor(a).\n")
								sair(entradaCadeia, contConsulta)
							pare

//---------------------------------------------------------

							caso 5:
								contRegistro = 0
								escreva("\t-- Relatório de pessoas do sexo feminino que moram em Gravataí --\n")
						 		para(i = 0; i < col; i++)
								{
									se(sexo[i] == "Feminino" e cidade[i] == "Gravataí" e cod[i] != -1)
									{
											lista(nome, cod, nascDia, nascMes, nascAno, id, sexo, prof, cidade, sang, i)
											contRegistro++
									}
								}
								escreva("\nHá ",contRegistro," pessoa(s) do sexo feminino que moram em Gravataí.\n")
								sair(entradaCadeia, contConsulta)
							pare

//---------------------------------------------------------

							caso contrario:
								limpa()
								escreva("Valor inválido!\n\n")
								u.aguarde(700)
						}
					}
				pare
				
//------------------------------------------------------------------------------------------------------	


				caso 7:
					limpa()
					escreva("Saindo do menu...\n")
					u.aguarde(700)
					menu = falso
				pare

//------------------------------------------------------------------------------------------------------	
					
				caso contrario:
					limpa()
					escreva("Valor inválido!\n\n")
					u.aguarde(700)	
   			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 714; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */