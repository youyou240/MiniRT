NAME = MiniRT
LIBFT_DIR = ./libraries/libft
LIBFT = $(LIBFT_DIR)/libft.a
MLX_DIR = ./libraries/minilibx-linux
MLX = $(MLX_DIR)/libmlx,a
LIBRARY = -L$(MLX_DIR) -lmlx -L$(LIBFT_DIR) -lft -lX11 -lXext -lm

VALGRIND = @valgrind --leak-check=full --show-leak-kinds=all \
	--track-origins=yes --quiet --tool=memcheck --keep-debuginfo=yes

LIBC = ar rcs
CC = cc
RM = rm -f

FLAGS = -Wall -Wextra -Werror -Iinc -g3

SRCS = main.c

OBJ_DIR = obj
OBJS = $(patsubst %.c,$(OBJ_DIR)/%.o,$(notdir $(SRCS)))

vpath %c

$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(FLAGS) -c $< -o $@

all :	$(NAME)

$(NAME) : ${OBJS} ${LIBFT} ${MLX}
	@echo "Building MiniRT.."
	@${CC} ${OBJS} $(FLAGS) $(LIBRARY) -o ${NAME}
	@echo "MiniRT is ready !"

valgrind: $(NAME)
	@echo "Running $(NAME) with Valgrind..."
	$(VALGRIND) ./$(NAME)


$(MLX) :
	@echo "Building mlx..."
	@make -C $(MLX_DIR)

$(LIBFT) :
	@echo "Building libft..."
	@make -C $(LIBFT_DIR)

clean:
	@echo "Cleaning..."
	@rm -rf $(OBJ_DIR)
	@make -C $(LIBFT_DIR) clean
	@make -C $(MLX_DIR) clean

fclean: clean
	@echo "Cleaning all..."
	@rm -f $(NAME)
	@make -C $(LIBFT_DIR) fclean
	@make -C $(MLX_DIR) fclean

re:         fclean all

.PHONY : all clean fclean re
