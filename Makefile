# cc := gcc
# cflags := -m32 -g

# trg := bin/program.out
# src := $(shell ls src/*.s)
# tmp := $(subst src/,obj/,$(src))
# obj := $(subst .s,.o,$(tmp))

# all: $(trg)

# $(trg): $(obj)
# 	@mkdir -p bin/
# 	$(cc) $(cflags) $^ -o $@

# obj/%.o: src/%.s
# 	@mkdir -p obj/
# 	$(cc) $(cflags) -c $< -o $@

# clean:
# 	rm -rf $(obj) $(trg)
