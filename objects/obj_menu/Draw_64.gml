/// @description desenhando na tela

if (!global.on_transition) //se não está em transição, roda o código
{
	//setando draw_set's
	draw_set_font(fnt_menu_01); //mudando a fonte
	draw_set_valign(fa_middle); //alinhando o texto verticalmente

	var _meio = display_get_gui_height() / 3;
	var _eixo_x = 15;
	var _fnt_height = string_height("I");

	for (var i = 0; i < array_length(menu); i++)
	{
		var _cor = c_white; //definindo a cor padrão
		var _space = 0; //variável que destaca o texto
	
		if (i == atual) //se o I for igual atual
		{
			_cor = c_red; //o texto fica de outra cor
			_space = space; //deixo destacado o texto selecionado
		}
	
		draw_set_colour(_cor);
		draw_text(_eixo_x + _space, _meio + i * (_fnt_height * 1.1), menu[i]); //desenhando o texto
		_eixo_x += 30;
		draw_set_colour(-1); //resetando a cor
	}
	//resetando draw_set's
	draw_set_font(-1); //resetando o draw_set
	draw_set_valign(0); //resetando o draw_set
}