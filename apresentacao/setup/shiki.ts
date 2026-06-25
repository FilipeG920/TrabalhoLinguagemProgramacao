import type { ShikiSetup } from '@slidev/types'

const setup: ShikiSetup = () => ({
  themes: {
    dark: 'github-dark-high-contrast',
    light: 'github-dark-high-contrast',
  },
  langs: ['c', 'java', 'haskell', 'prolog', 'txt'],
})

export default setup
