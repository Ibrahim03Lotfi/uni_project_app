<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
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
            'email' => $this->email,
            'phone' => $this->phone,
            'bio' => $this->bio,
            'profile_image' => $this->profile_image ? url($this->profile_image) : null,
            'role' => $this->role,
            'assigned_sport_id' => $this->assigned_sport_id,
            'assigned_sport' => $this->when($this->assignedSport, [
                'id' => $this->assignedSport->id,
                'name' => $this->assignedSport->name,
                'icon' => $this->assignedSport->icon ? url($this->assignedSport->icon) : null,
                'color' => $this->assignedSport->color,
                'emoji' => $this->assignedSport->emoji,
            ]),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
