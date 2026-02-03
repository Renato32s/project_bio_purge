//funções

//função de criar particulas
function particulas(_particula, _layer)
{
	instance_create_layer(x, y, _layer, _particula);
}

//função para balançar a tela(screenshake)
function screen_sacode(_sacode = 0)
{
	if (instance_exists(obj_screenshake)) //se o screenshake existe
	{
		with(obj_screenshake) //rodando a função dentro do objeto
		{
			if (_sacode > treme) //se o sacode for maior que o valor de treme
			{
				treme = _sacode; //treme recebe o valor de sacode
			}
		}
	}
}

//função para tocar os sons de efeitos
function fx_sound(_sound, _gain = 1, _pitch = 1, _loop = 0)
{
	audio_stop_sound(_sound); //parando os sons
	sound = audio_play_sound; //variável para tocar os sons
	
	sound(_sound, 0, _loop, _gain, 0, _pitch); //tocando
}

//função para mudar de room
function muda_room()
{
	room_goto(global.destino); //mudando de room
	audio_stop_all(); //parando os sons
}

//função cria trasição
function transition(_sequence = sq_transicao_01, _x = 0, _y = 0)
{
	layer_sequence_create("sq_transition", _x, _y, _sequence); //criando a sequence
}

//função para finalizar a transição
function finaliza_transition()
{
	global.on_transition = false;
}