cc := gcc
aflags := -m32 -g
lflags := -m32 -no-pie

trg := bin/program.out
src := $(shell ls src/*.s)
tmp := $(subst src/,obj/,$(src))
obj := $(subst .s,.o,$(tmp))

all: $(trg)

$(trg): $(obj)
	@mkdir -p bin/
	$(cc) $(lflags) $^ -o $@

obj/%.o: src/%.s
	@mkdir -p obj/
	$(cc) $(aflags) -c $< -o $@

clean:
	rm -rf $(obj) $(trg)
