package server

type SecretConfig struct {
	Sign string
	Salt string
}

type Config struct {
	Port string

	Secret SecretConfig
}

func DefaultConfig() *Config {
	return &Config{
		Port: "8000",
		Secret: SecretConfig{
			Sign: "LG9izuok29KsZF1TkaGIIwwDtZZBzDWYHaRHre1binCKVXT83roZ9oM2tN6iWhIb8WDV/a1zUHpo/7jmHk/QJ2DnYBPdnbxPxOzJ10yEynPpDtzpJS9dTVaWZ6VtFc56a9Wrs6JlI8rdFK7FbwwJP5QEeBT8YZlYObQmkApdPfWhNmBrVa3p5J5dg3ltPWDTHUFQospKVTTNRYuKHUDBpykjJz3iAsleQZo/o6MD/JXXaoaBEVXg7+WiDV8401HuC9DO+cFvTRLisGi6szA83nfklBMZka+T5b4P418G618FhLHPxZpyuCzmN77/ycTUBrPnYASiFJvTNxVfBNUbUvMYf1cpqD07QORT4RBUiiRr59Jv30mmkS7bZREbqBLPegR0utyLyRQe4GmRSMQnVEhjKaqogr0UGiJk8WNq2huiq2/3tSrbxT6c9b1JXZ9JKwGLJQm4vrj12fc/62im8gy9jQA2emQkJAuqVCzEzNAULyHaziae8U3LSagfLVXk5W1cGPjTgaNuJ0YNtG9sHPdXlbE6EV0qXN0dr7NfLiatvTqvwf1lCEqZ8MBMcaCrAcrPk9lYWcRBKtkpFINAHZD+ZtLMlpNbTmBqHZj0XRdDlgNILDOo8pD0jEzRzZf5j6NehFnKDf26qniaxLGDaf9OgZpqxjI0X9EBB4zSqgs=",
			Salt: "BDA3BFDFA868D04F4003838F5776F25E",
		},
	}
}
