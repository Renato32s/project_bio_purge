/// @description controla o objeto

//se não está na sequencia e foi criado em uma
if (!in_sequence and criado_na_sequencia)
{
	instance_destroy(); //se destruindo
}

//se não
if (!out_room) //está fora da room
{
	//inicia o alarme
	alarm[0] = irandom_range(120, 60);
}