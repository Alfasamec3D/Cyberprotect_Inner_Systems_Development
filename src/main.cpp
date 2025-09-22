#include <iostream>
#include <nlohmann/json.hpp>
#include <spdlog/spdlog.h>

int main() {
    // Содание JSON объекта
    nlohmann::json data;
    data["project"] = "demo-app";
    data["version"] = 1.0;
    data["features"] = {"logging", "json"};

    // Вывод данных JSON
    std::cout << "JSON data:\n" << data.dump(4) << std::endl;

    // spdlog
    spdlog::info("Application started!");
    spdlog::warn("This is just a demonstration!");
    spdlog::error("No errors actually, just showing log levels :)");

    return 0;
}
