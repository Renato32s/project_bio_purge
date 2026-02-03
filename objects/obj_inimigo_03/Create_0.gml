/// @description inicia o objeto

//rancomizando 
randomize();

//variáveis de vida e velocidade do tiro
vida		= 10;
vel_tiro	= 2;
vel		= 2;

//variável do efeito
efeito = false;

//variáveis de invencibilidade
timer_invencivel = 30;
tempo_invencivel = 0;

//variáveis para controlar o tiro
tempo_carregando	= 180;
timer_carregando	= 0;

//variável que conta os tiros
contador = 0;

//variável que decide a direção
decide_direcao = false;

//variável para controlar o estado
estado = "chegando";

//metodo para ficar branco
ativa_efeito = function()
{
	efeito = 5;
}
reseta_efeito = function()
{
	if (efeito > 0)
	{
		efeito--;
	}
}

//metodo de maquina de estados
estate_machine = function()
{
	switch(estado)
	{
		case "chegando": //caso chegando
		{
			vspeed = vel;
			
			if (y >= room_height / 4)
			{
				estado = "carregando";
			}
			
			break;
		}
		
		case "carregando": //caso carregando
		{
			vspeed = 0; //parando de se mover
			
			timer_carregando++; //aumentando o timer
			
			if (timer_carregando >= tempo_carregando)
			{
				timer_carregando = 0; //resetando o timer de recarga
				//tempo_carregando = 60; //passando o novo valor do tempo de recarga
				
				estado = choose("atirando", "atirando_02"); //indo para o estado de atirando
				
				contador++; //aumentando o contador
			}
				
			break;
		}
		
		case "atirando":
		{
			atirando(); //atirando
			
			if (contador < 3)
			{
				estado = "carregando"; //se já atirou, volta a carregar
			}
			else
			{
				estado = "fugindo"; //entra no estado de fuga
			}
			break;
		}
		
		case "atirando_02":
		{		
			atirando_02(); //atirando
			
			if (contador < 3)
			{
				estado = "carregando"; //voltando a carregar após atirar
			}
			else
			{
				estado = "fugindo"; //entra no estado de fuga
			}
			break;
		}
		
		case "fugindo":
		{
			if (!decide_direcao) //se não escolheu a direção
			{
				hspeed = choose(-2, 2); //se move horizontalmente
				vspeed = -1; //se move para cima
			
				decide_direcao = true; //foi decidido a direção
			}
			if (y < -64) //se o eixo_y for menor que a altura da room
			{
				instance_destroy(); //é destruindo ao sair da tela
			}
			
			break;
		}
	}
	
	tempo_invencivel--; //zerando o timer de invencibilidade
	reseta_efeito(); //resetando o efeito
}

//metodo para atirar
atirando = function()
{	
	if (!instance_exists(obj_player)) return; //se o player não existe, para de seguir
	
	//encontrando a posição do player
	var _direction_player = point_direction(x, y, obj_player.x, obj_player.y);
	
	var _tiro = instance_create_layer(x, y, "inst_tiro", obj_tiro_inimigo_03_A); //criando o tiro
	_tiro.speed = vel_tiro; //velocidade do tiro
	
	_tiro.direction	= _direction_player; //direção do tiro
	_tiro.image_angle	= _direction_player + 90; //angulo do tiro
}

//metodo para o segundo tiro
atirando_02 = function()
{
	if (!instance_exists(obj_player)) return; //se o player não existe para de atirar
	
	var _angulo = 255;
	repeat(100)
	{
		var _tiro = instance_create_layer(x, y, "inst_tiro", obj_tiro_inimigo_03_B); //criando o tiro
		_tiro.speed = vel_tiro; //velocidade do tiro		
		_tiro.direction = _angulo; //mudando a direção do tiro
		_tiro.image_angle = _tiro.direction + 90; //mudando o angulo do tiro
		
		_angulo += 15;
	}
}

//metodo para perder vida
perde_vida = function()
{
	if (tempo_invencivel > 0) return; //só perde vida se o timer estiver zerado
	ativa_efeito();
	
	if (vida > 1) //se vida for maior que zero
	{
		vida--; //perde vida
		
		tempo_invencivel = timer_invencivel; //ficando invencivel
		screen_sacode(10); //balança a tela ao tomar dano
	}
	else //se não
	{
		fx_sound(sfx_explosion, .4, choose(.5, .8), 0); //chamando o som da explosão
		instance_destroy(); //se destroi
		screen_sacode(50); //balança a tela mais forte ao morrer
	}
}

