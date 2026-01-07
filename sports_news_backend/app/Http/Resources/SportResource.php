<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SportResource extends JsonResource
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
            'name' => $this->name,
            'icon' => $this->icon ? url($this->icon) : null,
            'color' => $this->color,
            'description' => $this->description,
            'emoji' => $this->emoji,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
