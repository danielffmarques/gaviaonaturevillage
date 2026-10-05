// src/types/index.ts
// Gerado em colaboração com o Bionic AI Assistant

export type AccommodationCategory = 'cork-shelter' | 'glamping-tent' | 'camping';

export interface Accommodation {
  id: string;
  name: string;
  subtitle: string;
  category: AccommodationCategory;
  capacityMax: number;
  capacityLabel: string;
  areaM2?: number;
  description: string;
  amenities: string[];
  image: string;
  gallery: string[];
  badge?: string;
  features: {
    beds: string;
    wc: string;
    view: string;
  };
}

export type ExperienceJourney = 'casal' | 'familia' | 'wellness' | 'aventura';

export interface ExperienceProgram {
  id: string;
  title: string;
  journey: ExperienceJourney;
  subtitle: string;
  description: string;
  duration: string;
  highlights: string[];
  image: string;
  ctaText: string;
  targetAudience: string;
}

export interface Facility {
  id: string;
  title: string;
  tagline: string;
  description: string;
  image: string;
  icon: string;
}

export interface TrailRoute {
  code: string;
  name: string;
  distanceKm: number;
  difficulty: 'Fácil' | 'Médio' | 'Difícil';
  durationHours: string;
  description: string;
}

export interface FaqItem {
  question: string;
  answer: string;
  category: 'estadia' | 'wellness' | 'restaurante' | 'acessos';
}
