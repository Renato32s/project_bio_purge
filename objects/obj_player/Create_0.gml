/// @description iniciando o objeto

#region variáveis
//iniciando variável de velocidade do player
vel = 2;

//iniciando variável de velocidade do tiro
vel_tiro = 10;

//variáveis de espera e nivel do tiro
level_shoot	= 1;
timer_shoot	= 0;
wait = 10;


#endregion

#region metodos

//metodo para aumentar ou diminuir o level
tab_up_level = function()
{
	var _shift_up, _shift_down;
	_shift_up = keyboard_check_pressed(vk_up);
	_shift_down = keyboard_check_pressed(vk_down);
	
	if (_shift_up)
	{
		level_shoot++;
	}
	else if(_shift_down)
	{
		level_shoot--;
	}
	
	//limitando o tanto que pode aumentar o level do tiro
	level_shoot = clamp(level_shoot, 1, 3);
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
	tab_up_level();		//aumentando o level do tiro
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

#endregion