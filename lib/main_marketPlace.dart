import 'package:flutter/material.dart';

void main() {
  runApp(const MarketPlaceRuralApp());
}

// ============================================================
// CORES
// ============================================================

class AppColors {
  static const primary = Color(0xFF2E7D32);
  static const primaryDark = Color(0xFF1B5E20);
  static const lightGreen = Color(0xFFE8F5E9);
  static const background = Color(0xFFF7F8F6);
  static const text = Color(0xFF202420);
  static const gray = Color(0xFF6B716B);
  static const border = Color(0xFFE0E4E0);
}

// ============================================================
// USUÁRIO
// ============================================================

class UserData {
  String name;
  String email;
  String phone;
  String city;

  UserData({
    required this.name,
    required this.email,
    this.phone = '',
    this.city = '',
  });
}

// Usuário atualmente conectado.
// Como ainda não temos banco de dados,
// os dados ficam somente enquanto o app estiver aberto.
UserData? currentUser;

// ============================================================
// PRODUTO
// ============================================================

class Product {
  final String name;
  final String category;
  final double price;
  final String unit;
  final String producer;
  final String location;
  final String description;
  final IconData icon;
  final bool organic;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.producer,
    required this.location,
    required this.description,
    required this.icon,
    this.organic = false,
  });
}

// ============================================================
// CARRINHO
// ============================================================

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}

// ============================================================
// PEDIDO
// ============================================================

class Order {
  final String number;
  final String date;
  final String product;
  final String status;

  const Order({
    required this.number,
    required this.date,
    required this.product,
    required this.status,
  });
}

// ============================================================
// PRODUTOS
// ============================================================

final List<Product> products = [
  Product(
    name: 'Tomate Orgânico',
    category: 'Orgânicos',
    price: 8.90,
    unit: 'kg',
    producer: 'João da Silva',
    location: 'Mococa - SP',
    description:
        'Tomates produzidos de forma sustentável, colhidos recentemente e disponíveis para entrega.',
    icon: Icons.local_florist,
    organic: true,
  ),
  Product(
    name: 'Banana Nanica',
    category: 'Frutas',
    price: 5.90,
    unit: 'kg',
    producer: 'Maria Ferreira',
    location: 'Mococa - SP',
    description:
        'Bananas nanicas frescas, selecionadas e prontas para entrega.',
    icon: Icons.eco,
  ),
  Product(
    name: 'Alface Crespa',
    category: 'Hortaliças',
    price: 3.50,
    unit: 'un',
    producer: 'Produção Familiar',
    location: 'Mococa - SP',
    description:
        'Alface crespa fresca, cultivada por produtor familiar da região.',
    icon: Icons.grass,
  ),
  Product(
    name: 'Milho',
    category: 'Grãos',
    price: 4.80,
    unit: 'kg',
    producer: 'Carlos Oliveira',
    location: 'Mococa - SP',
    description:
        'Milho selecionado produzido por agricultor da região.',
    icon: Icons.grain,
  ),
  Product(
    name: 'Leite Integral',
    category: 'Laticínios',
    price: 6.50,
    unit: 'L',
    producer: 'Fazenda Boa Vista',
    location: 'Mococa - SP',
    description:
        'Leite integral produzido e preparado para comercialização local.',
    icon: Icons.local_drink,
  ),
  Product(
    name: 'Mel Artesanal',
    category: 'Outros',
    price: 18.90,
    unit: '500g',
    producer: 'Apicultura Rural',
    location: 'Mococa - SP',
    description:
        'Mel artesanal produzido por apicultores da região.',
    icon: Icons.water_drop,
  ),
];

// ============================================================
// PEDIDOS
// ============================================================

final List<Order> orders = [
  const Order(
    number: '#2278',
    date: '11/03/2026',
    product: 'Banana Nanica',
    status: 'A caminho',
  ),
  const Order(
    number: '#2267',
    date: '31/03/2026',
    product: 'Tomate',
    status: 'Concluído',
  ),
  const Order(
    number: '#2998',
    date: '01/03/2026',
    product: 'Alface crespa',
    status: 'Recebido',
  ),
];

// ============================================================
// GERENCIADOR DO CARRINHO
// ============================================================

class CartManager extends ChangeNotifier {
  final List<CartItem> items = [];

  int get itemCount {
    int total = 0;

    for (final item in items) {
      total += item.quantity;
    }

    return total;
  }

  double get total {
    double value = 0;

    for (final item in items) {
      value += item.total;
    }

    return value;
  }

  void addProduct(Product product) {
    final index = items.indexWhere(
      (item) => item.product.name == product.name,
    );

    if (index >= 0) {
      items[index].quantity++;
    } else {
      items.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void increase(CartItem item) {
    item.quantity++;
    notifyListeners();
  }

  void decrease(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }

    notifyListeners();
  }

  void remove(CartItem item) {
    items.remove(item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

final CartManager cart = CartManager();

// ============================================================
// APP
// ============================================================

class MarketPlaceRuralApp extends StatelessWidget {
  const MarketPlaceRuralApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarketPlace Rural',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool remember = false;

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage(
        context,
        'Preencha o e-mail e a senha para entrar.',
      );
      return;
    }

    // Sem banco de dados:
    // cria um usuário temporário usando o e-mail.
    String temporaryName = email.split('@').first;

    if (temporaryName.isEmpty) {
      temporaryName = 'Usuário';
    }

    currentUser = UserData(
      name: temporaryName,
      email: email,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainPage(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.agriculture,
                      size: 42,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Center(
                  child: Text(
                    'MarketPlace Rural',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                const Center(
                  child: Text(
                    'Acesse sua conta',
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  'E-mail',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration(
                    'seu@email.com',
                    Icons.email_outlined,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Senha',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: inputDecoration(
                    'Digite sua senha',
                    Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: remember,
                      onChanged: (value) {
                        setState(() {
                          remember = value ?? false;
                        });
                      },
                    ),
                    const Text('Lembrar acesso'),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        showMessage(
                          context,
                          'Digite seu e-mail para recuperar a senha.',
                        );
                      },
                      child: const Text(
                        'Esqueci minha senha',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Entrar na plataforma',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('ou'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Criar conta gratuita',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Center(
                  child: Text(
                    'Ao continuar você concorda com os\n'
                    'Termos de Uso e a Política de Privacidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// CADASTRO
// ============================================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isProducer = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();

  void createAccount() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final city = cityController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        city.isEmpty ||
        password.isEmpty) {
      showMessage(
        context,
        'Preencha todos os campos para criar sua conta.',
      );
      return;
    }

    // Salva os dados preenchidos pelo usuário.
    currentUser = UserData(
      name: name,
      email: email,
      phone: phone,
      city: city,
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const MainPage(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar sua conta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha como você deseja utilizar o\n'
              'MarketPlace Rural',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: roleCard(
                    title: 'Sou produtor',
                    subtitle: 'Quero vender\nmeus produtos',
                    icon: Icons.agriculture,
                    selected: isProducer,
                    onTap: () {
                      setState(() {
                        isProducer = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: roleCard(
                    title: 'Sou comprador',
                    subtitle: 'Quero encontrar e\ncomprar produtos',
                    icon: Icons.shopping_cart_outlined,
                    selected: !isProducer,
                    onTap: () {
                      setState(() {
                        isProducer = false;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            registerField(
              'Nome completo',
              'Seu nome',
              nameController,
              Icons.person_outline,
            ),

            registerField(
              'E-mail',
              'seu@email.com',
              emailController,
              Icons.email_outlined,
            ),

            registerField(
              'Telefone',
              '(19) 99999-9999',
              phoneController,
              Icons.phone_outlined,
            ),

            registerField(
              'Cidade/Região',
              'Mococa - SP',
              cityController,
              Icons.location_on_outlined,
            ),

            registerField(
              'Senha',
              'Digite sua senha',
              passwordController,
              Icons.lock_outline,
              obscure: true,
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: createAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Criar minha conta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Já tem uma conta? Entrar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget roleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.lightGreen
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 7),
          TextField(
            controller: controller,
            obscureText: obscure,
            decoration: inputDecoration(
              hint,
              icon,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PÁGINA PRINCIPAL
// ============================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    cart.addListener(updatePage);
  }

  void updatePage() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cart.removeListener(updatePage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onOpenCart: openCart,
      ),
      ProductsPage(
        onOpenCart: openCart,
      ),
      const OrdersPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: cart.itemCount == 0
                ? const Icon(Icons.shopping_bag_outlined)
                : Badge(
                    label: Text('${cart.itemCount}'),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                  ),
            selectedIcon: const Icon(Icons.shopping_bag),
            label: 'Produtos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      floatingActionButton: cart.itemCount > 0
          ? FloatingActionButton.extended(
              onPressed: openCart,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(
                Icons.shopping_cart,
              ),
              label: Text(
                'Carrinho (${cart.itemCount})',
              ),
            )
          : null,
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CartPage(),
      ),
    );
  }
}

// ============================================================
// INÍCIO
// ============================================================

class HomePage extends StatelessWidget {
  final VoidCallback onOpenCart;

  const HomePage({
    super.key,
    required this.onOpenCart,
  });

  @override
  Widget build(BuildContext context) {
    final userName =
        currentUser?.name.isNotEmpty == true
            ? currentUser!.name
            : 'Usuário';

    final userCity =
        currentUser?.city.isNotEmpty == true
            ? currentUser!.city
            : 'Sua região';

    final categories = [
      ['Grãos', Icons.grain],
      ['Hortaliças', Icons.grass],
      ['Frutas', Icons.apple],
      ['Carnes', Icons.restaurant],
      ['Orgânicos', Icons.eco],
      ['Laticínios', Icons.local_drink],
      ['Bebidas', Icons.local_cafe],
      ['Outros', Icons.more_horiz],
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          100,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.agriculture,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bom dia, $userName! 👋',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              userCity,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.gray,
                              ),
                              overflow:
                                  TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Stack(
                  children: [
                    IconButton(
                      onPressed: onOpenCart,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: 4,
                        top: 3,
                        child: Container(
                          padding:
                              const EdgeInsets.all(4),
                          decoration:
                              const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'O que você está procurando?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: inputDecoration(
                'Buscar produtos...',
                Icons.search,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                const Text(
                  'Categorias',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todos'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return categoryItem(
                    context,
                    categories[index][0] as String,
                    categories[index][1] as IconData,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text(
                  'Produtos perto de você',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('Ver todos'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            productCard(
              context,
              products[0],
              showCartButton: true,
            ),

            productCard(
              context,
              products[1],
              showCartButton: true,
            ),

            const SizedBox(height: 5),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.location_searching,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sugestão para você',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Encontramos produtos a até 20 km de você com disponibilidade para esta semana.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        showMessage(
          context,
          'Categoria: $title',
        );
      },
      child: Container(
        width: 82,
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PRODUTOS
// ============================================================

class ProductsPage extends StatefulWidget {
  final VoidCallback onOpenCart;

  const ProductsPage({
    super.key,
    required this.onOpenCart,
  });

  @override
  State<ProductsPage> createState() =>
      _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.name
          .toLowerCase()
          .contains(search.toLowerCase());
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              10,
            ),
            child: Row(
              children: [
                const Text(
                  'Produtos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Stack(
                  children: [
                    IconButton(
                      onPressed: widget.onOpenCart,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                      ),
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: 2,
                        top: 0,
                        child: Container(
                          padding:
                              const EdgeInsets.all(4),
                          decoration:
                              const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: inputDecoration(
                'Buscar produto...',
                Icons.search,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum produto encontrado.',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      10,
                      20,
                      100,
                    ),
                    itemCount:
                        filteredProducts.length,
                    itemBuilder: (context, index) {
                      return productCard(
                        context,
                        filteredProducts[index],
                        showCartButton: true,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CARD DE PRODUTO
// ============================================================

Widget productCard(
  BuildContext context,
  Product product, {
  bool showCartButton = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: AppColors.border,
      ),
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProductDetailPage(
                  product: product,
                ),
              ),
            );
          },
          child: Container(
            height: 145,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius:
                  BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Icon(
              product.icon,
              size: 70,
              color: AppColors.primary,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  if (product.organic)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            AppColors.lightGreen,
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: const Text(
                        'Orgânico',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              AppColors.primaryDark,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                product.producer,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: AppColors.gray,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    product.location,
                    style: const TextStyle(
                      color: AppColors.gray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Text(
                    'R\$ ${formatPrice(product.price)}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    '/${product.unit}',
                    style: const TextStyle(
                      color: AppColors.gray,
                    ),
                  ),
                  const Spacer(),
                  if (showCartButton)
                    IconButton(
                      onPressed: () {
                        cart.addProduct(product);

                        showMessage(
                          context,
                          '${product.name} foi adicionado ao carrinho.',
                        );
                      },
                      style:
                          IconButton.styleFrom(
                        backgroundColor:
                            AppColors.primary,
                        foregroundColor:
                            Colors.white,
                      ),
                      icon: const Icon(
                        Icons.add_shopping_cart,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// DETALHES DO PRODUTO
// ============================================================

class ProductDetailPage
    extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState
    extends State<ProductDetailPage> {
  int quantity = 1;

  void addToCart() {
    for (int i = 0; i < quantity; i++) {
      cart.addProduct(widget.product);
    }

    showMessage(
      context,
      '$quantity unidade(s) adicionada(s) ao carrinho.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do produto',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CartPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              color: AppColors.lightGreen,
              child: Icon(
                product.icon,
                size: 100,
                color: AppColors.primary,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'R\$ ${formatPrice(product.price)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    '/${product.unit}',
                    style: const TextStyle(
                      color: AppColors.gray,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Sobre o produto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: const TextStyle(
                      color: AppColors.gray,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Produtor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            AppColors.lightGreen,
                        child: Icon(
                          Icons.person,
                          color:
                              AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.producer,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color:
                                      Colors.amber,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '4,9 (128 avaliações)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        AppColors
                                            .gray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Quantidade',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      quantityButton(
                        Icons.remove,
                        () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),

                      Padding(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 22,
                        ),
                        child: Text(
                          '$quantity',
                          style:
                              const TextStyle(
                            fontSize: 19,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      quantityButton(
                        Icons.add,
                        () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child:
                        ElevatedButton.icon(
                      onPressed: addToCart,
                      icon: const Icon(
                        Icons
                            .shopping_cart_outlined,
                      ),
                      label: const Text(
                        'Adicionar ao carrinho',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primary,
                        foregroundColor:
                            Colors.white,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quantityButton(
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}

// ============================================================
// CARRINHO
// ============================================================

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() =>
      _CartPageState();
}

class _CartPageState
    extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    cart.addListener(refreshCart);
  }

  void refreshCart() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    cart.removeListener(refreshCart);
    super.dispose();
  }

  void finishOrder() {
    if (cart.items.isEmpty) {
      showMessage(
        context,
        'Seu carrinho está vazio.',
      );
      return;
    }

    final productNames = cart.items
        .map(
          (item) =>
              '${item.product.name} (${item.quantity})',
        )
        .join(', ');

    final newOrder = Order(
      number: '#${3000 + orders.length}',
      date: '19/08/2026',
      product: productNames,
      status: 'Recebido',
    );

    orders.insert(0, newOrder);

    cart.clear();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 55,
          ),
          title: const Text(
            'Pedido realizado!',
          ),
          content: const Text(
            'Seu pedido foi registrado com sucesso.\n\n'
            'Esta é uma simulação, então nenhuma compra real foi realizada.',
            textAlign: TextAlign.center,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Continuar',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu carrinho',
        ),
      ),
      body: cart.items.isEmpty
          ? emptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(20),
                    itemCount:
                        cart.items.length,
                    itemBuilder:
                        (context, index) {
                      final item =
                          cart.items[index];

                      return cartItem(item);
                    },
                  ),
                ),
                checkoutArea(),
              ],
            ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius:
                    BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 50,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seu carrinho está vazio',
              style: TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Adicione produtos para continuar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.gray,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primary,
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                'Ver produtos',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartItem(CartItem item) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              item.product.icon,
              color: AppColors.primary,
              size: 35,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'R\$ ${formatPrice(item.product.price)}/${item.product.unit}',
                  style:
                      const TextStyle(
                    color: AppColors.gray,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    smallButton(
                      Icons.remove,
                      () {
                        cart.decrease(item);
                      },
                    ),

                    Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        '${item.quantity}',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    smallButton(
                      Icons.add,
                      () {
                        cart.increase(item);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            children: [
              IconButton(
                onPressed: () {
                  cart.remove(item);

                  showMessage(
                    context,
                    '${item.product.name} removido do carrinho.',
                  );
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),

              Text(
                'R\$ ${formatPrice(item.total)}',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  color:
                      AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget smallButton(
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 17,
        ),
      ),
    );
  }

  Widget checkoutArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        15,
        20,
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset:
                const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
              const Spacer(),
              Text(
                'R\$ ${formatPrice(cart.total)}',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Row(
            children: [
              Text(
                'Entrega',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
              Spacer(),
              Text(
                'A calcular',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),

          const Divider(
            height: 25,
          ),

          Row(
            children: [
              const Text(
                'Total',
                style:
                    TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'R\$ ${formatPrice(cart.total)}',
                style:
                    const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                  color:
                      AppColors.primaryDark,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: finishOrder,
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.primary,
                foregroundColor:
                    Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              child: const Text(
                'Finalizar pedido',
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PEDIDOS
// ============================================================

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() =>
      _OrdersPageState();
}

class _OrdersPageState
    extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
                EdgeInsets.fromLTRB(
              20,
              20,
              20,
              5,
            ),
            child: Text(
              'Meus pedidos',
              style:
                  TextStyle(
                fontSize: 25,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const Padding(
            padding:
                EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              'Acompanhe seus pedidos e entregas',
              style:
                  TextStyle(
                color:
                    AppColors.gray,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child:
                ListView.builder(
              padding:
                  const EdgeInsets.all(
                20,
              ),
              itemCount:
                  orders.length,
              itemBuilder:
                  (context, index) {
                final order =
                    orders[index];

                return orderCard(
                  order,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget orderCard(Order order) {
    Color statusColor;

    switch (order.status) {
      case 'Concluído':
        statusColor = Colors.green;
        break;

      case 'A caminho':
        statusColor = Colors.orange;
        break;

      default:
        statusColor =
            AppColors.primary;
    }

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),
      padding:
          const EdgeInsets.all(16),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          15,
        ),
        border: Border.all(
          color:
              AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Pedido ${order.number}',
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Text(
                order.date,
                style:
                    const TextStyle(
                  color:
                      AppColors.gray,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration:
                    BoxDecoration(
                  color:
                      AppColors.lightGreen,
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
                child: const Icon(
                  Icons
                      .shopping_basket_outlined,
                  color:
                      AppColors.primary,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  order.product,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color:
                    statusColor,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                order.status,
                style:
                    TextStyle(
                  color:
                      statusColor,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PERFIL
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final name =
        currentUser?.name.isNotEmpty == true
            ? currentUser!.name
            : 'Usuário';

    final email =
        currentUser?.email.isNotEmpty == true
            ? currentUser!.email
            : '';

    return SafeArea(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          100,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 43,
              backgroundColor:
                  AppColors.lightGreen,
              child: Icon(
                Icons.person,
                size: 45,
                color:
                    AppColors.primary,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              name,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              email,
              style:
                  const TextStyle(
                color:
                    AppColors.gray,
              ),
            ),

            const SizedBox(height: 8),

            Container(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration:
                  BoxDecoration(
                color:
                    AppColors.lightGreen,
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),
              child:
                  const Text(
                '✓ Conta verificada',
                style:
                    TextStyle(
                  color:
                      AppColors.primaryDark,
                  fontSize: 12,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Minha conta',
                style:
                    TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            profileOption(
              context,
              Icons.person_outline,
              'Dados pessoais',
            ),

            profileOption(
              context,
              Icons.location_on_outlined,
              'Endereços',
            ),

            profileOption(
              context,
              Icons.credit_card_outlined,
              'Formas de pagamento',
            ),

            profileOption(
              context,
              Icons.receipt_long_outlined,
              'Meus pedidos',
            ),

            profileOption(
              context,
              Icons.tune,
              'Preferências',
            ),

            profileOption(
              context,
              Icons.notifications_none,
              'Notificações',
            ),

            profileOption(
              context,
              Icons.palette_outlined,
              'Aparência',
            ),

            profileOption(
              context,
              Icons.map_outlined,
              'Região',
            ),

            const SizedBox(height: 15),

            const Align(
              alignment:
                  Alignment.centerLeft,
              child: Text(
                'Configurações',
                style:
                    TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            profileOption(
              context,
              Icons.security_outlined,
              'Segurança',
            ),

            profileOption(
              context,
              Icons.lock_outline,
              'Alterar senha',
            ),

            profileOption(
              context,
              Icons.privacy_tip_outlined,
              'Privacidade',
            ),

            profileOption(
              context,
              Icons.language,
              'Idioma',
              trailing: 'Português',
            ),

            profileOption(
              context,
              Icons.help_outline,
              'Central de ajuda',
            ),

            profileOption(
              context,
              Icons.support_agent,
              'Falar com o suporte',
            ),

            profileOption(
              context,
              Icons.info_outline,
              'Sobre o aplicativo',
            ),

            const SizedBox(height: 15),

            ListTile(
              onTap: () {
                cart.clear();

                // Limpa o usuário atual.
                currentUser = null;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const LoginPage(),
                  ),
                  (route) => false,
                );
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Sair da conta',
                style:
                    TextStyle(
                  color: Colors.red,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileOption(
    BuildContext context,
    IconData icon,
    String title, {
    String? trailing,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 4,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          12,
        ),
      ),
      child: ListTile(
        onTap: () {
          showMessage(
            context,
            '$title selecionado.',
          );
        },
        leading: Icon(
          icon,
          color:
              AppColors.primary,
        ),
        title: Text(title),
        trailing: trailing != null
            ? Text(
                trailing,
                style:
                    const TextStyle(
                  color:
                      AppColors.gray,
                ),
              )
            : const Icon(
                Icons.chevron_right,
                color:
                    AppColors.gray,
              ),
      ),
    );
  }
}

// ============================================================
// FUNÇÕES AUXILIARES
// ============================================================

String formatPrice(double value) {
  return value
      .toStringAsFixed(2)
      .replaceAll('.', ',');
}

InputDecoration inputDecoration(
  String hint,
  IconData icon,
) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border:
        OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(
        12,
      ),
      borderSide:
          const BorderSide(
        color:
            AppColors.border,
      ),
    ),
    enabledBorder:
        OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(
        12,
      ),
      borderSide:
          const BorderSide(
        color:
            AppColors.border,
      ),
    ),
    focusedBorder:
        OutlineInputBorder(
      borderRadius:
          BorderRadius.circular(
        12,
      ),
      borderSide:
          const BorderSide(
        color:
            AppColors.primary,
        width: 2,
      ),
    ),
  );
}

void showMessage(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context)
      .hideCurrentSnackBar();

  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(message),
      behavior:
          SnackBarBehavior.floating,
      duration:
          const Duration(
        seconds: 2,
      ),
    ),
  );
}