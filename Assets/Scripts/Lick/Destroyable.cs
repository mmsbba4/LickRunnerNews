using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Lick
{
    public enum DestroyType
    {
        Freezee,
        Fire,
        Cut,
        Decorticate
    }
    public class Destroyable : MonoBehaviour
    {
        PlayerMove player;
        public bool is_active;
        private void Update()
        {
            if (!is_active) return;
            if (player.pressed_value < 5 && player.is_can_control)
            {
                player.SetDestroyable(type);
            }
        }
        public Transform dicorated_transform;
        public DestroyType type;
        private void OnTriggerEnter(Collider other)
        {
            
            if(other.GetComponent<Tongue>() != null)
            {
                player = other.GetComponent<Tongue>().GetComponentInParent<PlayerMove>();
                if (dicorated_transform != null)
                {
                    player.Decorticate_position = dicorated_transform.position;
                }
                is_active = true;
            }
        }
        private void OnTriggerExit(Collider other)
        {
            if (other.GetComponent<Tongue>() != null)
            {
                is_active = false;
            }
        }
    }
}

