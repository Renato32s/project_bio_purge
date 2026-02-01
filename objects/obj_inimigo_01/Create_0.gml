/// @description inicia o objeto

//randomizando o comportamento
randomise();

//verifica se está fora da room
out_room = false; //iniciando com false

//variável que verifica se o inimigo está em uma sequencia
criado_na_sequencia = in_sequence;

//variáveis de velocidade do inimigo e do tiro dele
vel		= 5;
vel_tiro	= 6;

//iniciando o alarme
//alarm[0] = irandom_range(120, 60);

//metodo para criar o tiro
atirando = function()
{
	var _tiro = instance_create_layer(x + .8, y, "inst_tiro", obj_tiro_inimigo_01); //criando o tiro do inimigo e passando para uma variável temporária
	_tiro.vspeed = vel_tiro;
}