# Имя итогового бинарника
TARGET := app

# Компилятор и флаги
CXX := g++
CXXFLAGS := -std=c++17 -O2 -Iinclude

# Директории
SRC_DIR := src
BUILD_DIR := build
DEPS_DIR := deps

# Список исходников
SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))

# Внешние зависимости
DEPS := $(DEPS_DIR)/spdlog $(DEPS_DIR)/json

.PHONY: all clean deps run

all: deps $(TARGET)

# Правило сборки бинарника
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# Компиляция отдельных cpp
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -I$(DEPS_DIR)/spdlog/include -I$(DEPS_DIR)/json/include -c $< -o $@

# Клонирование зависимостей
deps: $(DEPS)

$(DEPS_DIR)/spdlog:
	@mkdir -p $(DEPS_DIR)
	git clone --depth 1 https://github.com/gabime/spdlog.git $@

$(DEPS_DIR)/json:
	@mkdir -p $(DEPS_DIR)
	git clone --depth 1 https://github.com/nlohmann/json.git $@

# Очистка
clean:
	rm -rf $(BUILD_DIR) $(TARGET)

# Запуск программы
run: all
	./$(TARGET)
