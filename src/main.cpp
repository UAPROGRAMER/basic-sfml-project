#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>

void render(sf::RenderWindow *window) {
  window->setActive(true);

  while (window->isOpen()) {
    window->clear(sf::Color::Black);

    window->display();
  }
}

int main() {
  sf::RenderWindow window(sf::VideoMode(800, 600), "Pinpong");
  window.setFramerateLimit(60);
  window.setActive(false);

  sf::Thread renderThread(&render, &window);
  renderThread.launch();

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      switch (event.type) {
      case sf::Event::Closed:
        window.close();
        break;
      default:
        break;
      }
    }
    sf::sleep(sf::seconds(1.f / 60.f));
  }

  renderThread.wait();

  return 0;
}
