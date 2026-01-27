/// @description iniciando o objeto

#region variáveis
//iniciando variável de velocidade do player
vel = 2;

//iniciando variável de velocidade do tiro
vel_tiro = 10;

//variáveis de espera do tiro
timer_shoot	= 0;
wait = 10;


#endregion

#region metodos

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
	
	if (_shoot && timer_shoot <= 0) 
	{ //se eu atirar
		var _tiro = instance_create_layer(x, y, "inst_tiro", obj_tiro_player);
		_tiro.vspeed			= -vel_tiro;
		//_tiro.direction	= image_angle;
		
		//resetando o timer do tiro
		timer_shoot = wait;
	}
	
	var _vel_h = (_right - _left) * vel;
	var _vel_v = (_down - _up) * vel;
	
	x += _vel_h;
	y += _vel_v;
	
	limit_player(); //impedindo o player de sair da room
}

#endregion