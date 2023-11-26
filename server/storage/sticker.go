package storage

import (
	"gitlab.com/tatsiyev/audio-stream/models"
)

type StickerStorage struct {
	Server *models.Server
}

var stickers = []*models.StickerPack{
	{Name: "Стикерпак 1",
		Stickers: []string{
			"/uploads/stickers/pack1/Property 1=free-sticker-angry-6133425.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-angry-6133465.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-confused-6133487.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-confused-6133501.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-disappointed-6133470.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-excited-6133479.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-happy-6133430.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-happy-6133522.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-in-love-6133528.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-relief-6133422.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-sad-6133450.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-scared-6133460.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-shocked-6133515.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-surprised-6133439.png",
			"/uploads/stickers/pack1/Property 1=free-sticker-worried-6133420 (1).png",
		}},
	{Name: "Стикерпак 2",
		Stickers: []string{
			"/uploads/stickers/pack2/Property 1=free-sticker-advertising-11463415.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-comment-11463403.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-comment-11463413.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-like-11463416.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-likes-11463407.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-message-11463408.png",
			"/uploads/stickers/pack2/Property 1=free-sticker-message-11463412.png",
		}},
	{Name: "Стикерпак 3",
		Stickers: []string{
			"/uploads/stickers/pack4/Property 1=free-sticker-angel-4860792.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-angry-4860828.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-annoyed-4860859.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-bored-4860811.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-cry-4860869.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-devil-4860781.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-dizzy-4860797.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-excited-4860844.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-happy-4860774.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-hungry-4860851.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-shocked-4860820.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-sleepy-4860802.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-surprised-4860766.png",
			"/uploads/stickers/pack4/Property 1=free-sticker-wink-4860836.png",
		}},
}

func (s *StickerStorage) GetAllStickers() []*models.StickerPack {
	return stickers
}

func NewStickerStorage(s *models.Server) models.StickerInterface {
	return &StickerStorage{
		Server: s,
	}
}
