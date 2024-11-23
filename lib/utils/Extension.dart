import 'dart:math';

class Extension{

  static String generateToken(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+-=[]{}|;:,.<>?';
    Random random = Random();

    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }

}