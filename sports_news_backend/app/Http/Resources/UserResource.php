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
            'assigned_sport' => $this->when($this->assignedSport, function() {
                return [
                    'id' => $this->assignedSport->id,
                    'name' => $this->assignedSport->name,
                    'icon' => $this->assignedSport->icon ? url($this->assignedSport->icon) : null,
                    'color' => $this->assignedSport->color,
                    'emoji' => $this->assignedSport->emoji,
                ];
            }),
            'preferred_sports' => $this->whenLoaded('preferredSports', function() {
                return $this->preferredSports->map(function($sport) {
                    return [
                        'id' => $sport->id,
                        'name' => $sport->name,
                        'icon' => $sport->icon ? url($sport->icon) : null,
                        'color' => $sport->color,
                        'emoji' => $sport->emoji,
                        'description' => $sport->description,
                    ];
                });
            }),
            'preferred_leagues' => $this->whenLoaded('preferredLeagues', function() {
                return $this->preferredLeagues->map(function($league) {
                    return [
                        'id' => $league->id,
                        'name' => $league->name,
                        'country' => $league->country,
                        'logo' => $league->logo ? url($league->logo) : null,
                        'sport_id' => $league->sport_id,
                        'sport_name' => $league->sport ? $league->sport->name : null,
                    ];
                });
            }),
            'preferred_teams' => $this->whenLoaded('preferredTeams', function() {
                return $this->preferredTeams->map(function($team) {
                    return [
                        'id' => $team->id,
                        'name' => $team->name,
                        'country' => $team->country,
                        'logo' => $team->logo ? url($team->logo) : null,
                        'league_id' => $team->league_id,
                        'league_name' => $team->league ? $team->league->name : null,
                        'sport_name' => $team->sport ? $team->sport->name : null,
                    ];
                });
            }),
            'preferred_players' => $this->whenLoaded('preferredPlayers', function() {
                return $this->preferredPlayers->map(function($player) {
                    return [
                        'id' => $player->id,
                        'name' => $player->name,
                        'position' => $player->position,
                        'nationality' => $player->nationality,
                        'image' => $player->image ? url($player->image) : null,
                        'team_name' => $player->team ? $player->team->name : null,
                        'sport_name' => $player->sport ? $player->sport->name : null,
                    ];
                });
            }),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
