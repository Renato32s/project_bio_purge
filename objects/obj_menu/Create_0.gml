/// @description iniciando o objeto

//array do menu
menu = ["play", "tutorial", "exit"];

atual = 0; //variável para controlar o texto escolhido
space = 20; //variável de margem 

//metodo de controle
control = function()
{
	var _up, _down, _enter; //variáveis de seleção
	
	_up		= keyboard_check_pressed(vk_up); //se pressionar seta cima
	_down		= keyboard_check_pressed(vk_down); //se pressionar seta baixo
	_enter	= keyboard_check_pressed(vk_enter); //se pressionar enter
	
	if (_up) //se pressiona seta pra cima
	{
		atual--; //se pressionar pra cima baixa o valor
		fx_sound(sfx_selection_01, 1, 1.4); //som da seleção
		space = 0; //zerando a margem
	}
	
	if (_down) //se pressiona seta pra baixo
	{
		atual++; //se pressionar pra baixo aumenta o valor
		fx_sound(sfx_selection_01, 1, 1.5); //som da seleção
		space = 0; //zerando a margem
	}
	
	if (_enter) //se pressiona tecla enter
	{
		switch(atual)
		{
			case 0: //jogar
			{
				transition();
				global.on_transition = true; //está rodando a transição
				global.destino = rm_gameplay;
				break;
			}
			
			case 1: //turorial
			{
				transition();
				global.on_transition = true; //está rodando a transição
				global.destino = rm_tutorial;
				break;
			}
			
			case 2: //sair
			{
				game_end(); //saindo do game
				
				break;
			}
			
		}
	}
	
	atual = clamp(atual, 0, array_length(menu) - 1); //limitando o quando pode aumentar e diminuir
	space = lerp(space, 20, .08); //transição suave da margem
}