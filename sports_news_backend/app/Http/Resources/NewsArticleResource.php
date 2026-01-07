<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class NewsArticleResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'description' => $this->description,
            'content' => $this->content,
            'image_url' => $this->image_url ? url($this->image_url) : null,
            'category' => $this->category,
            'published_at' => $this->published_at,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'likes_count' => $this->whenCounted('likes'),
            'is_liked' => $this->when(isset($this->is_liked), (bool) $this->is_liked),
            'author' => [
                'id' => $this->author->id,
                'name' => $this->author->name,
                'email' => $this->author->email,
                'role' => $this->author->role,
            ],
            'sport' => [
                'id' => $this->sport->id,
                'name' => $this->sport->name,
                'icon' => $this->sport->icon,
                'color' => $this->sport->color,
                'emoji' => $this->sport->emoji,
            ],
            'team' => $this->when($this->team, [
                'id' => $this->team->id,
                'name' => $this->team->name,
                'logo_url' => $this->team->logo_url ? url($this->team->logo_url) : null,
                'country' => $this->team->country,
            ]),
        ];
    }
}
