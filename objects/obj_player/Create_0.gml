/// @description iniciando o objeto

#region variáveis
//iniciando variável de velocidade do player
vel = 2;

//variáveis de escala
xscale = 1;
yscale = 1;

//variável de controle do shader
tomei_dano = false;

//variáveis de vidas e escudos
vidas			= 5;
escudos		= 5;
meu_escudo	= noone;

//iniciando variável de velocidade do tiro
vel_tiro = 10;

//variáveis de espera e nivel do tiro
level_shoot	= 1;
timer_shoot	= 0;
wait = 10;

//variáveis de invencibilidade
tempo_invencivel = 60;
timer_invencivel = 0;

//variável de criar instancias
create = instance_create_layer;

#endregion

#region metodos

//metodos do shader
shader_dano = function()
{
	tomei_dano = 5;
}
reseta_shader = function()
{
	if (tomei_dano > 0)
	{
		tomei_dano--;
	}
}

//metodo para usar o escudo
use_shield = function()
{
	var _usa_shield = keyboard_check_pressed(ord("E")); //se pressiona a tecla E
	if (meu_escudo == noone)
	if (_usa_shield and escudos >= 1)	
	{
		fx_sound(sfx_shield_up, .5); //som do escudo
		meu_escudo = create(x, y, "inst_escudos", obj_shield); //criando o escudo
		escudos--; //perdendo escudo
	}
	
	//verificando se eu tenho escudo
	if (instance_exists(meu_escudo)) //se tenho escudo
	{
		//meu escudo segue o player
		meu_escudo.x = x;	//no eixo_x
		meu_escudo.y = y;	//no eixo_y
	}
	else
	{
		meu_escudo = noone; //se não meu escudo é noone
	}
}

//metodo para perder vida e morrer
perde_vida = function()
{
	if (instance_exists(meu_escudo)) return; //só perde vida qaundo o escudo acaba
	
	if (timer_invencivel > 0) return; //só perde vida se não está invencivel
	shader_dano(); //fica branco ao tomar dano
	
	if (vidas > 1) //se a vida for maior que um
	{
		vidas--; //perdendo vida
		
		timer_invencivel = tempo_invencivel; //ficando invencivel
		screen_sacode(20); //balançando a tela ao tomar dano
		
		estica_e_puxa(2, .5); //esticando ao tomar dano
	}
	else //se vida for menor ou igual a 0
	{
		instance_destroy(); //o player morre
		screen_sacode(70); //balando a tela mais forte ao morrer
		transition(sq_transicao_01); //roda a sequencia
		global.on_transition = true;
	}
}

//metodo para aumentar ou diminuir o level, vidas, escudos ou sair do game
tab_up_level = function()
{
	var _shift_up, _shift_down, _reset, _end_game;
	_shift_up	= keyboard_check_pressed(vk_up);
	_shift_down	= keyboard_check_pressed(vk_down);
	_end_game	= keyboard_check_pressed(vk_escape);
	_reset		= keyboard_check_pressed(ord("R"));
	
	if (_reset) //reseta o game
	{
		transition(sq_transicao_01, x - 144, y - 256);	//roda a transição
		global.on_transition = true; //está rodando a transição
	}
	
	if (_end_game) game_end();	//finalizando o jogo se apertar a tecla ESC
	
	if (_shift_up)
	{
		level_shoot++;
		vidas++;
		escudos++;
	}
	else if(_shift_down)
	{
		level_shoot--;
		vidas--;
		escudos--;
	}
	
	//limitando o tanto que pode aumentar o level do tiro
	level_shoot	= clamp(level_shoot, 1, 3);
	
	//limitando as vidas e os escudos
	vidas			= clamp(vidas, 1, 5);
	escudos		= clamp(escudos, 0, 5);
	timer_invencivel--; //zerando o tempo de invencibilidade
}

//metodo para impedir que o player saia da tela
limit_player = function()
{
	//se ele tentar sair pela direita ou esquerda
	x = clamp(x, sprite_width / 2, room_width - sprite_width / 2);
	
	//se ele tentar sair por cima ou por baixo
	y = clamp(y, sprite_height / 2, room_height - (sprite_height / 2) + 5);
}

//metodo de movimentação
player_control = function()
{	
	var _left, _right, _up, _down, _shoot; //variáveis temporárias de controle
	
	_left		= keyboard_check(ord("A")); //pra esquerda com a tecla A
	_right	= keyboard_check(ord("D")); //pra direita com a tecla D
	_down		= keyboard_check(ord("S")); //pra baixo com a tecla S
	_up		= keyboard_check(ord("W")); //pra cima com a tecla W
	
	//pegando a tecla de atirar
	_shoot	= keyboard_check(vk_space) or mouse_check_button(mb_left); //atira com a tecla (space) ou btn left do mouse
	
	//zerando o tempo do tiro
	timer_shoot--;
	if (_shoot && timer_shoot <= 0) //atirando
	{ //se eu atirar
		estica_e_puxa(); //esticando
		fx_sound(sfx_laser_02, .5, choose(1, 1.2, 1.5, 1.7, 1.8), 0); //criando o som do tiro
		
		switch(level_shoot) //a cada level o tiro muda
		{
			case 1:
			{
				bullet_1(); //tiro padrão
				break;
			}
			
			case 2:
			{
				bullet_2(); //tiro elevado 2x
				break;
			}
			
			case 3:
			{
				bullet_3(); //tiro elevado 3x
				break;
			}
		}
		
		//resetando o timer do tiro
		timer_shoot = wait;
	}
	
	var _vel_h = (_right - _left) * vel; //movimento horizontal(eixo_x)
	var _vel_v = (_down - _up) * vel; //movimento vertical(eixo_y)
	
	x += _vel_h; //o x é igual vel_h
	y += _vel_v; //o y é igual vel_v
	
	normal_sprite(); //normaliza a sprite
	reseta_shader(); //resetando o sahder
	limit_player(); //impedindo o player de sair da room
	tab_up_level();	//aumentando o level do tiro
	use_shield();	//usando o escudo
}

//metodo para ganhar level
up_level = function()
{
	level_shoot++;
	level_shoot = clamp(level_shoot, 1, 3); //limitando os niveis
}

//metodo estica e achata
estica_e_puxa = function(_eixo_x = 1.3, _eixo_y = .7)
{
	xscale = _eixo_x;
	yscale = _eixo_y;
}

//metodo para voltar ao normal
normal_sprite = function()
{
	xscale = lerp(xscale, 1, .2);
	yscale = lerp(yscale, 1, .2);
}

//região dos tiros
#region level dos tiros
//tiro no level 1
bullet_1 = function()
{
	var _tiro = create(x, y - 10, "inst_tiro", obj_tiro_player);
		_tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro, .1);
		//_tiro.direction	= image_angle;
}

//tiro no level 2
bullet_2 = function()
{
	var _tiro = create(x - 12, y - 10, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro, .1);
		 _tiro = create(x + 12, y - 10, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro, .1);
		//_tiro.direction	= image_angle;
}

//tiro level 03
bullet_3 = function()
{
	var _tiro = create(x, y - 10, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro - .1, .17);
		 _tiro = create(x - 12, y - 10, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro, .1);
		 _tiro = create(x + 12, y - 10, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = lerp(_tiro.vspeed, -vel_tiro, .1);
}

#endregion

//metodo de desenhar sprite
desenha_sprite = function(_sprite, _gui_w = 220, _space_h = 30, _img_alpha = 1)
{
	var _gui_h		= display_get_gui_height();
	var _x_scale	= 1;
	var _y_scale	= 1;
	var _img_angle	= 0;
	var _sub_image	= 0;
	var _color		= c_white;
	
	
	draw_sprite_ext(_sprite, _sub_image, _gui_w, _gui_h - _space_h, _x_scale, _y_scale, _img_angle, _color, _img_alpha);
}

//metodo para desenhar na GUI usando o metodo desenha_sprite
desenha_gui = function(_sprite, _qtd, _x_base, _y_base, _sep, _alpha = 0.6)
{
    for (var i = 0; i < _qtd; i++) 
    {
        //calculando o deslocamento multiplicando o índice (i) pelo espaçamento
        //se _sep for negativo, eles se afastam para um lado, se positivo, para o outro.
        var _shift = i * _sep;
        
        //chamamodo a função desenha_sprite e passando a posição calculada
        desenha_sprite(_sprite, _x_base + _shift, _y_base, _alpha);
    }
}


#endregion

//chamando a sequencia
transition(sq_transicao_02, x - 144, y - 256); //rodando a transição
global.destino = rm_start; //definindo o destino
global.on_transition = true; //está rodando a transição