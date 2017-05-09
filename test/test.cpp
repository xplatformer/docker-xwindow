#include <iostream>
#include <sstream>

using namespace std;

// Simple comment
class Customer {
public:
    string name;
    int id;
};

int main()
{
    Customer obj;

    std::cout << "Enter the ID :";
    std::cin >> obj.id;

    std::cout << "Enter the Name :";
    std::cin >> obj.name;

    std::cout << obj.name << ": " << obj.id << std::endl;

    return 0;
}