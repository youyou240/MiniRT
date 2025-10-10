#include "libraries/windows/windows.h"
#include "minirt.h"

int main(int arg, char **argv)
{
	t_win	*prog;
	(void)arg;
	prog = create_window(argv[1], XSIZE, YSIZE);
	mlx_hook(prog->win_ptr, DestroyNotify, 0, free_windows, prog);
	mlx_key_hook(prog->win_ptr, print_input_key, &prog->img);
	create_fade(prog->img, gen_trgb(0, 0, 0, 255), gen_trgb(0, 0, 255, 0));
	create_overlay((t_overlay){gen_trgb(50, 255, 0, 0), 400, 250, 920, 1000}, prog->img);
	mlx_put_image_to_window(prog->mlx_ptr, prog->win_ptr, prog->img, 0, 0);
	mlx_loop(prog->mlx_ptr);
	return (0);
}

