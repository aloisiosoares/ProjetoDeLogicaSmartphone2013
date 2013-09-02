/*

SMPDignosis v1.0
Atualizacao em 19/08/2013 22:30

CIn UFPE
Sistemas de Informa��o 2013.1
L�gica para Computa��o
Alunos: Alo�sio Soares
	Fagner Fernandes
	Leandro Augusto
	Marcos Rocha

Programa para diagn�stico de problemas em um smartphone

Digite ?- iniciar para interagir com o programa

*/

iniciar :- defeito(Problema), solucao(Solucao),
      write('Defeito : '),
      write(Problema),
      nl,
      write('Solucao : '),
      write(Solucao),
      nl,
      undo.

/* Defeitos */
defeito(desligado) :- desligado, !.
defeito(bateria_descarregada) :- bateriadescarregada, !.
defeito(bateria_desconectada) :- bateriadesconectada, !.
defeito(bateria_defeito_de_fabrica) :- defeito_de_fabrica, !.
defeito(memoria_flash_queimada) :- defeito_memoria_flash, !.
defeito(memoria_ram_queimada) :- defeito_memoria_ram, !.
defeito(memoria_ram_mal_encaixada) :- defeito_memoria_ram2, !.
defeito(memoria_ram_com_problema) :- defeito_memoria_ram_geral.
defeito(touchscreen_quebrado) :- defeito_touchscreen, !.
defeito(som_nao_sai1) :- defeito_som_nao_sai1, !.
defeito(som_nao_sai2) :- defeito_som_nao_sai2, !.
defeito(som_desconhecido) :- defeito_som_desconhecido, !.
defeito(wifi_nao_funciona) :- defeito_antena_wifi, !.
defeito(wifi_nao_funciona2) :- defeito_sinal_fraco, !. 
defeito(aparelho_nao_faz_ligacao) :- defeito_nao_faz_ligacao, !.
defeito(aparelho_nao_faz_ligacao2) :- defeito_nao_faz_ligacao2, !.

defeito(problema_nao_identificado) :- defeito_nao_identificado.

/* Solu��es - associacao da solucao ao defeito registrado acima */
solucao(ligar) :- defeito(desligado), !.
solucao(carregue_a_bateria) :- defeito(bateria_descarregada), !.
solucao(reconecte_a_bateria) :- defeito(bateria_desconectada), !.
solucao(va_a_assistencia_tecnica_ou_a_loja) :- defeito(bateria_defeito_de_fabrica), !.
solucao(troque_a_memoria_flash) :- defeito(memoria_flash_queimada), !.
solucao(troque_a_memoria_ram_defeituosa) :- defeito(memoria_ram_queimada), !.
solucao(encaixe_novamente_a_memoria) :- defeito(memoria_ram_mal_encaixada), !.
solucao(verifique_o_slot_das_memorias) :- defeito(memoria_ram_com_problema), !.
solucao(trocar_touchscreen) :- defeito(touchscreen_quebrado), !.
solucao(habilite_dispositivo_de_som) :- defeito(som_nao_sai1), !.
solucao(troque_dispositivo_de_som) :- defeito(som_nao_sai2), !.
solucao(veja_se_driver_esta_compativel_com_sistema_operacional) :- defeito(som_desconhecido), !.
solucao(troque_placa_wifi) :- defeito(wifi_nao_funciona), !.
solucao(mude_de_lugar) :- defeito(wifi_nao_funciona2), !.
solucao(mude_o_local_da_ligacao) :- defeito(aparelho_nao_faz_ligacao), !.
solucao(troque_de_aparelho) :- defeito(aparelho_nao_faz_ligacao2), !.

solucao(desconhecido) :- defeito(problema_nao_identificado), !.

/* identifica��o das regras */
desligado :- aparelho_nao_liga, !.
bateriadescarregada :- descarregada, !.
bateriadesconectada :- desconectada, !.
defeito_de_fabrica :- bateria_defeito_fabrica, !.
defeito_memoria_ram :- memoriaramqueimada, !.
defeito_memoria_ram2 :- memoria_mal_encaixada, !.
defeito_memoria_ram_geral :- memoria_ram_com_problema.
defeito_memoria_flash :- memoriaflashqueimada, !.
defeito_touchscreen :- touchscreen_defeituoso, !.
defeito_som_nao_sai1 :- som_desabilitado, !.
defeito_som_nao_sai2 :- somquebrado, !.
defeito_som_desconhecido :- problema_som_desconhecido, !.
defeito_antena_wifi :- antena_wifi_nao_funciona, !.
defeito_sinal_fraco :- lugar_inapropriado, !.
defeito_nao_faz_ligacao :- sinal_operadora_presente, !.
defeito_nao_faz_ligacao2 :- nao_faz_ligacao, !.

defeito_nao_identificado :- desconhecido.

/* categoria de problemas */

smartphone_com_problema :- verifique('Seu smartphone est� com algum problema.').

aparelho_nao_liga :- smartphone_com_problema,
		     not( verifique('Apertou o bot�o de ligar.') ).

descarregada :- smartphone_com_problema,
		not( verifique('Sua bateria est� carregada.') ).

desconectada :- smartphone_com_problema,
		not( descarregada ),
		not( verifique('Sua bateria esta conectada corretamente ao aparelho.') ).

bateria_defeito_fabrica :- aparelho_nao_liga,
			   verifique('Voc� adquiriu recentemente seu aparelho.'),
			   verifique('Nunca deu defeito antes.').

memoriaflashqueimada :- smartphone_com_problema,
			not( verifique('Mem�ria Flash do aparelho est� funcionando.') ).

memoria_ram_com_problema :- smartphone_com_problema,
			    not(verifique('Memoria RAM esta funcionando normalmente.')).

memoriaramqueimada :- smartphone_com_problema,
		      memoria_ram_com_problema,
		      verifique('Testou a memoria RAM em outro aparelho.'),
		      not(verifique('Funcionou nesse aparelho.')).

memoria_mal_encaixada :- smartphone_com_problema,
			 memoria_ram_com_problema,
			 not(verifique('Mem�ria RAM est� encaixada corretamente.')).

memoria_ram_nao_funcionando :- memoria_ram_com_problema.

touchscreen_defeituoso :- smartphone_com_problema,
			  not( verifique('Seu touchscreen funciona.') ).

som_no_mudo :- smartphone_com_problema,
	       verifique('Aparelho est� mudo.'), !.

som_desabilitado :- som_no_mudo,
		    not(verifique('Dispositivo de som est� habilitado.')).

somquebrado :- smartphone_com_problema,
	       som_no_mudo,
	       not( verifique('LED da placa de som acesa no chipset.') ).

problema_som_desconhecido :- som_no_mudo,
			     not(som_desabilitado),
			     not(somquebrado).

sinal_wifi_presente :- smartphone_com_problema,
		       verifique('Sinal do wifi est� presente.').

antena_wifi_nao_funciona :- smartphone_com_problema,
			    not(sinal_wifi_presente),
			    not(verifique('Antena wifi esta funcionando corretamente.')).

consegue_fazer_ligacao :- smartphone_com_problema,
			  verifique('Consegue fazer liga��o normalmente').

sinal_operadora_presente :- smartphone_com_problema,
			    verifique('Sinal da operadora est� presente'),
			    not(consegue_fazer_ligacao).

lugar_inapropriado :- smartphone_com_problema,
		      not(sinal_wifi_presente),
		      verifique('No local onde vc est�, outras pessoas tamb�m n�o conseguem usar wifi').

discagem_correta :- smartphone_com_problema,
		    not(consegue_fazer_ligacao),
		    verifique('Voc� discou o n�mero certo').

nao_faz_ligacao :- discagem_correta,
		   not(sinal_operadora_presente).

desconhecido :- not(smartphone_com_problema).

/* fazendo perguntas ao usu�rio */
pergunta(Question) :-
    write('Responda: '),
    write(Question),
    write('? '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assert(sim(Question)) ;
       assert(nao(Question)), fail).

:- dynamic sim/1,nao/1.

/* Verificar resposta do usu�rio */
verifique(S) :-
   (sim(S)
    ->
    true ;
    (nao(S)
     ->
     fail ;
     pergunta(S))).

/* limpar respostas anteriores */
reset :- retract(yes(_)),fail.
reset :- retract(no(_)),fail.
reset.

/* Desfazer as afirma��es */
undo :- retract(sim(_)),fail.
undo :- retract(nao(_)),fail.
undo.



