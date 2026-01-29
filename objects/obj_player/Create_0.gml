/// @description iniciando o objeto

#region variáveis
//iniciando variável de velocidade do player
vel = 2;

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


#endregion

#region metodos

//metodo para usar o escudo
use_shield = function()
{
	var _usa_shield = keyboard_check_pressed(ord("E")); //se pressiona a tecla E
	if (meu_escudo == noone)
	if (_usa_shield and escudos >= 1)	
	{
		meu_escudo = instance_create_layer(x, y, "inst_escudos", obj_shield);
		escudos--; //perdendo escudo
	}
	
	//verificando se eu tenho escudo
	if (instance_exists(meu_escudo)) //se tenho esculdo
	{
		//meu esculdo segue o player
		meu_escudo.x = x;	//no eixo_x
		meu_escudo.y = y;	//no eixo_y
	}
	else
	{
		meu_escudo = noone;
	}
}

//metodo para perder vida e morrer
perde_vida = function()
{
	if (timer_invencivel > 0) return; //só perde vida se não está invencivel
	
	if (vidas > 1) //se a vida for maior que zero
	{
		vidas--; //perdendo vida
		
		timer_invencivel = tempo_invencivel; //ficando invencivel
	}
	else //se vida for menor ou igual a 0
	{
		instance_destroy(); //o player morre
	}
}

//metodo para aumentar ou diminuir o level, vidas, escudos ou sair do game
tab_up_level = function()
{
	var _shift_up, _shift_down, _end_game;
	_shift_up	= keyboard_check_pressed(vk_up);
	_shift_down	= keyboard_check_pressed(vk_down);
	_end_game	= keyboard_check_pressed(vk_escape);
	
	if (_end_game) game_end(); //finalizando o jogo se apertar a tecla ESC
	
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
		
		switch(level_shoot) //a cada level o tiro muda
		{
			case 1:
				bullet_1(); //tiro padrão
			break;
			
			case 2:
				bullet_2(); //tiro elevado 2x
			break;
			
			case 3:
				bullet_3(); //tiro elevado 3x
			break;
		}
		
		//resetando o timer do tiro
		timer_shoot = wait;
	}
	
	var _vel_h = (_right - _left) * vel; //movimento horizontal(eixo_x)
	var _vel_v = (_down - _up) * vel; //movimento vertical(eixo_y)
	
	x += _vel_h; //o x é igual vel_h
	y += _vel_v; //o y é igual vel_v
	
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

//região dos tiros
#region level dos tiros
//tiro no level 1
bullet_1 = function()
{
	var _tiro = instance_create_layer(x, y, "inst_tiro", obj_tiro_player);
		_tiro.vspeed			= -vel_tiro;
		//_tiro.direction	= image_angle;
}

//tiro no level 2
bullet_2 = function()
{
	var _tiro = instance_create_layer(x - 12, y - 5, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = -vel_tiro;
		 _tiro = instance_create_layer(x + 12, y - 5, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = -vel_tiro;
		//_tiro.direction	= image_angle;
}

//tiro level 03
bullet_3 = function()
{
	var _tiro = instance_create_layer(x, y - 2, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = -vel_tiro - .6;
		 _tiro = instance_create_layer(x - 12, y - 5, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = -vel_tiro;
		 _tiro = instance_create_layer(x + 12, y - 5, "inst_tiro", obj_tiro_player);
		 _tiro.vspeed = -vel_tiro;
}

#endregion

//metodo de desenhar sprite
desenha_sprite = function(_sprite, _gui_w = 220, _space_h = 30, _img_alpha = image_alpha)
{
	var _gui_h		= display_get_gui_height();
	var _x_scale	= image_xscale;
	var _y_scale	= image_yscale;
	var _img_angle	= image_angle;
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