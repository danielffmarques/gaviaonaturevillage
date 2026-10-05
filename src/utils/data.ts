import type { Accommodation, ExperienceProgram, Facility, FaqItem } from '../types';

export const ACCOMMODATIONS: Accommodation[] = [
  {
    id: 'cork-shelter-standard',
    name: 'Cork Shelter Standard',
    subtitle: 'Conexão essencial com isolamento térmico e acústico em cortiça natural',
    category: 'cork-shelter',
    capacityMax: 2,
    capacityLabel: 'Até 2 Pessoas',
    areaM2: 26,
    description: 'Compostos por cama de casal e casa de banho privada completa. Um destes abrigos está totalmente adaptado para pessoas com mobilidade reduzida.',
    amenities: ['Wi-Fi Gratuito', 'Ar Condicionado Individual', 'Mini-frigorífico', 'Smart TV', 'Chaleira Elétrica', 'Secador de Cabelo', 'Cofre', 'Closet'],
    image: '/images/alojamentos/media_7_Gavi_o.jpg',
    gallery: [
      '/images/alojamentos/media_7_Gavi_o.jpg',
      '/images/alojamentos/media_10_Gavi_o.jpg',
      '/images/alojamentos/media_42_Gavi_o.jpg',
      '/images/alojamentos/media_9_Gavi_o.jpg'
    ],
    badge: 'Eco-Isolamento em Cortiça',
    features: {
      beds: '1 Cama de Casal Queen',
      wc: 'Casa de Banho Privativa Completa',
      view: 'Vista para a Natureza e Vinhedo'
    }
  },
  {
    id: 'cork-shelter-superior',
    name: 'Cork Shelter Superior',
    subtitle: 'Espaço generoso com cama de casal e beliche para pequenas famílias ou casais',
    category: 'cork-shelter',
    capacityMax: 4,
    capacityLabel: 'Até 4 Pessoas',
    description: 'Compostos por zona de quarto com cama de casal e beliche embutido, casa de banho completa e uma confortável área de estar com luz natural.',
    amenities: ['Wi-Fi Gratuito', 'Ar Condicionado Individual', 'Mini-frigorífico', 'Smart TV', 'Chaleira Elétrica', 'Secador', 'Pequena Sala de Estar'],
    image: '/images/alojamentos/media_11_Gavi.jpg',
    gallery: [
      '/images/alojamentos/media_11_Gavi.jpg',
      '/images/alojamentos/media_12_Gavi_o.jpg',
      '/images/alojamentos/media_10_Gavi_o.jpg',
      '/images/alojamentos/media_42_Gavi_o.jpg'
    ],
    badge: 'Ideal para Casais com Filhos',
    features: {
      beds: '1 Cama de Casal + 1 Beliche',
      wc: 'Casa de Banho Completa',
      view: 'Deck Exterior Privativo'
    }
  },
  {
    id: 'cork-shelter-familiar',
    name: 'Cork Shelter Familiar',
    subtitle: 'Dois quartos privados e ampla sala comum para grandes famílias ou grupos',
    category: 'cork-shelter',
    capacityMax: 8,
    capacityLabel: 'Até 8 Pessoas',
    description: 'Dois quartos privados independentes, cada um com cama de casal, beliche e casa de banho completa própria, partilhando uma ampla zona de convívio com mesa de refeições.',
    amenities: ['2 WCs Completos', '2 Quartos Privados', 'Wi-Fi Gratuito', 'Ar Condicionado Duplo', 'Mini-frigorífico', 'Smart TV', 'Sala Comum'],
    image: '/images/alojamentos/media_8_Gavi_o.jpg',
    gallery: [
      '/images/alojamentos/media_8_Gavi_o.jpg',
      '/images/alojamentos/media_12_Gavi_o.jpg',
      '/images/alojamentos/media_11_Gavi.jpg',
      '/images/alojamentos/media_9_Gavi_o.jpg'
    ],
    badge: 'Máxima Capacidade (8 Pax)',
    features: {
      beds: '2 Camas de Casal + 2 Beliches',
      wc: '2 Casas de Banho Privadas',
      view: 'Vista Ampla sobre o Montado'
    }
  },
  {
    id: 'tenda-amor-perfeito',
    name: 'Tenda Amor Perfeito',
    subtitle: 'Glamping romântico com vista privilegiada para o vinhedo e montado alentejano',
    category: 'glamping-tent',
    capacityMax: 2,
    capacityLabel: '2 Pessoas (Romântico)',
    description: 'Na tenda glamping dedicada ao amor e romantismo, desfrute de todo o requinte com cama de casal decorada, deck privativo sob o sobreiro, ar condicionado e casa de banho completa.',
    amenities: ['Cama de Casal Exclusiva', 'Vista Panorâmica da Vinha', 'Casa de Banho Completa', 'Ar Condicionado', 'Minibar', 'Deck Privativo'],
    image: '/images/alojamentos/media_27_Gavi_o.jpg',
    gallery: [
      '/images/alojamentos/media_27_Gavi_o.jpg',
      '/images/alojamentos/media_26_Gavi_o.jpg',
      '/images/alojamentos/media_28_Gavi.jpg',
      '/images/village/media_33_Gavi.jpg'
    ],
    badge: 'Especial Casais & Lua de Mel',
    features: {
      beds: '1 Cama de Casal King Size',
      wc: 'Casa de Banho Privada',
      view: 'Deck e Vista Privilegiada para o Vinhedo'
    }
  },
  {
    id: 'tenda-glamping-familiar',
    name: 'Glamping Familiar',
    subtitle: 'A magia do campismo de luxo na natureza com cama de casal e beliche em madeira',
    category: 'glamping-tent',
    capacityMax: 4,
    capacityLabel: 'Até 4 Pessoas',
    description: 'Ideal para uma escapadela em família. Dispõe de cama de casal, beliche embutido em madeira para as crianças, ampla janela panorâmica e casa de banho completa privativa.',
    amenities: ['Casa de Banho Privada', 'Ar Condicionado Individual', 'Minibar', 'Cofre', 'Chaleira Elétrica', 'Wi-Fi Gratuito'],
    image: '/images/alojamentos/media_121_Gavi_o.jpg',
    gallery: [
      '/images/alojamentos/media_121_Gavi_o.jpg',
      '/images/alojamentos/media_124_Gavi_o.jpg',
      '/images/alojamentos/media_122_Gavi_o.jpg',
      '/images/alojamentos/media_123_Gavi_o.jpg'
    ],
    badge: 'Aventura para Crianças',
    features: {
      beds: '1 Cama de Casal + 1 Beliche',
      wc: 'Casa de Banho Completa Privativa',
      view: 'Jardins e Paisagem da Herdade'
    }
  },
  {
    id: 'tenda-glamping-amigos',
    name: 'Glamping Amigos',
    subtitle: '30 m² com camas individuais para retiros ou viagens entre amigos',
    category: 'glamping-tent',
    capacityMax: 4,
    capacityLabel: '4 Camas Individuais',
    areaM2: 30,
    description: 'Dispõe de camas individuais e casa de banho completa privada, oferecendo o espaço perfeito para conviver com amigos em pleno contacto com a natureza alentejana.',
    amenities: ['Camas Individuais', 'Casa de Banho Privada', 'Ar Condicionado', 'Minibar', 'Smart TV', 'Wi-Fi de Alta Velocidade'],
    image: '/images/alojamentos/media_25_Gavi.jpg',
    gallery: [
      '/images/alojamentos/media_25_Gavi.jpg',
      '/images/alojamentos/media_43_Gavi_o.jpg',
      '/images/village/media_48_Gavi_o.jpg',
      '/images/village/media_33_Gavi.jpg'
    ],
    badge: 'Perfeito para Grupos / Caminheiros',
    features: {
      beds: '4 Camas Individuais de Solteiro',
      wc: 'Casa de Banho Completa Privada',
      view: 'Envolvente Natural Tranquila do Village'
    }
  }
];

export const EXPERIENCE_PROGRAMS: ExperienceProgram[] = [
  {
    id: 'lua-de-mel',
    title: 'Lua de Mel & Romantismo',
    journey: 'casal',
    subtitle: 'Uma celebração inspirada na lenda de Belver e no céu estrelado do Alentejo',
    description: 'Para acomodar os recém-casados e casais em celebração, um programa sensorial com estadia na Tenda Amor Perfeito, acesso ao spa e jantar a dois com vista panorâmica.',
    duration: '2 ou 3 Noites',
    highlights: ['Cama redonda com vista vinhas', 'Circuito de Bem-Estar a dois', 'Jantar romântico no Cadafaz', 'Cocktails no Sky Lounge'],
    image: '/images/programas/media_57_Gavi_o.jpg',
    ctaText: 'Ver Programa Romântico',
    targetAudience: 'Casais, Luas de Mel, Aniversários'
  },
  {
    id: 'familia-no-campo',
    title: 'Família no Campo',
    journey: 'familia',
    subtitle: 'Desconexão dos ecrãs, ar puro e contacto diário com os animais da herdade',
    description: 'Uma escapadela familiar diferente: as crianças alimentam os animais na quinta pedagógica, brincam no parque e mergulham na piscina exterior ecológica.',
    duration: 'Fim de semana ou Férias',
    highlights: ['Cork Shelter Familiar com beliches', 'Quinta pedagógica e animais', 'Piscina exterior ecológica', 'Trilhos fáceis para crianças'],
    image: '/images/programas/media_58_Gavi_o.jpg',
    ctaText: 'Ver Programa Familiar',
    targetAudience: 'Famílias com Crianças e Jovens'
  },
  {
    id: 'reconnect-thrive',
    title: 'Reconnect & Thrive',
    journey: 'wellness',
    subtitle: 'Revitalização holística do corpo e da mente no silêncio do Cadafaz',
    description: 'Retiro anti-stress que combina o circuito de bem-estar diário (jacuzzi, sauna e banho turco) com massagens terapêuticas e alimentação equilibrada.',
    duration: '3 a 5 Dias',
    highlights: ['Acesso diário ilimitado ao spa', 'Desconto exclusivo em massagens', 'Paz absoluta e caminhadas meditativas', 'Opções saudáveis no restaurante'],
    image: '/images/programas/media_59_Gavi_o.jpg',
    ctaText: 'Ver Retiro de Bem-Estar',
    targetAudience: 'Viajantes em Burnout, Ioga, Retiros Pessoais'
  },
  {
    id: 'trilhos-aventura',
    title: 'Trilhos, Tejo & Aventura',
    journey: 'aventura',
    subtitle: 'Passadiços do Alamal, 5 percursos pedestres e voos de balão de ar quente',
    description: 'Explore o curso do Rio Tejo a partir da praia fluvial do Alamal, percorra os passadiços de madeira em falésia e admire as vistas medievais do Castelo de Belver.',
    duration: 'Estadias Ativas',
    highlights: ['Passadiços do Alamal a 5 min', 'Rotas PR1, PR2, PR3, PR4 e PR8', 'Voo de Balonismo disponível', 'Recuperação muscular no spa'],
    image: '/images/experiencias/media_104_Gavi_o.jpg',
    ctaText: 'Ver Roteiros de Aventura',
    targetAudience: 'Praticantes de Trekking, Desporto e Natureza'
  }
];

export const FACILITIES: Facility[] = [
  {
    id: 'piscina',
    title: 'Piscina Exterior',
    tagline: 'Mergulho refrescante no coração da planície',
    description: 'Enquadrada pela vegetação autóctone e vinhedos, equipada com espreguiçadeiras e serviço de bar para as tardes quentes alentejanas.',
    image: '/images/village/media_15_Gavi_o.jpg',
    icon: 'pool'
  },
  {
    id: 'animais',
    title: 'Cantinho dos Animais & Horta',
    tagline: 'Quinta pedagógica biológica',
    description: 'Um espaço de carinho e aprendizagem onde as crianças e adultos podem interagir com póneis, cabrinhas anãs e aves em ambiente natural.',
    image: '/images/village/media_1_Gavi.jpg',
    icon: 'heart'
  },
  {
    id: 'vinhas',
    title: 'Vinhas Velhas',
    tagline: 'A alma enológica de Cadafaz',
    description: 'Parcelas de vinhas históricas preservadas na herdade, testemunhas da tradição vitivinícola que abastece a carta do nosso restaurante.',
    image: '/images/village/media_36_Gavi_o.jpg',
    icon: 'wine'
  },
  {
    id: 'parque',
    title: 'Parque Infantil & Jogos',
    tagline: 'Diversão segura ao ar livre',
    description: 'Parque de madeira integrado na paisagem com baloiços, escorregas e tenda recreativa para atividades em família com total tranquilidade.',
    image: '/images/village/media_34_Gavi_o.jpg',
    icon: 'smile'
  }
];

export const FAQS: FaqItem[] = [
  {
    category: 'estadia',
    question: 'Quais são os horários de check-in e check-out?',
    answer: 'O check-in realiza-se a partir das 16h00 e o check-out até às 12h00. Quem reserva diretamente no site oficial beneficia de prioridade para early check-in ou late check-out gratuito, mediante disponibilidade do alojamento.'
  },
  {
    category: 'wellness',
    question: 'O acesso ao Wellness Center está incluído na reserva?',
    answer: 'Sim! As reservas efetuadas diretamente no nosso site oficial incluem acesso gratuito ao Circuito Wellness (jacuzzi / hidromassagem, sauna e banho turco), além de 15% de desconto nas massagens corporais e 5% nos rituais.'
  },
  {
    category: 'estadia',
    question: 'Todas as tendas Glamping e Cork Shelters têm casa de banho privada?',
    answer: 'Sim, sem exceção. Todas as unidades — tanto os 10 Cork Shelters ecológicos como as 13 tendas Glamping — possuem casa de banho completa privada com duche, água quente e produtos de higiene.'
  },
  {
    category: 'restaurante',
    question: 'Qual é o horário e o tipo de cozinha do Restaurante Cadafaz?',
    answer: 'O Restaurante Cadafaz serve almoços das 12h30 às 15h00 e jantares das 19h00 às 22h00. A cozinha homenageia as receitas alentejanas com um toque moderno, incluindo opções vegetarianas, veganas e sem glúten mediante solicitação.'
  },
  {
    category: 'acessos',
    question: 'Como chegar de transportes públicos até ao Gavião Nature Village?',
    answer: 'De comboio pela Linha da Beira Baixa (ligação direta a Lisboa e Entroncamento), saindo na estação de Belver situada a apenas 3 km do hotel. Há também carreiras de autocarro para o centro de Gavião (a 3 km). Mediante aviso prévio, podemos organizar transfer da estação.'
  },
  {
    category: 'acessos',
    question: 'Existem postos de carregamento para carros elétricos?',
    answer: 'Sim, dispomos de pontos de carregamento elétrico no nosso estacionamento privativo para que os hóspedes possam viajar de forma sustentável pelo Alto Alentejo.'
  },
  {
    category: 'estadia',
    question: 'Existe aquecimento e ar condicionado no interior das tendas?',
    answer: 'Sim, todas as tendas Glamping e Cork Shelters estão equipadas com unidades individuais de ar condicionado (frio e quente), assegurando conforto térmico rigoroso tanto nas tardes de verão como nas noites de inverno.'
  },
  {
    category: 'wellness',
    question: 'É necessário marcar previamente os tratamentos de spa e massagens?',
    answer: 'Recomendamos a marcação antecipada no momento da reserva ou com pelo menos 24h de antecedência para garantir a disponibilidade de horários dos nossos terapeutas.'
  }
];
